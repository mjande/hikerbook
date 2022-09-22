class Comment < ApplicationRecord
  include ActionView::RecordIdentifier # to use dom_id method

  belongs_to :user
  belongs_to :post

  validates :body, presence: true, length: { maximum: 140 }

  scope :persisted, -> { where 'id IS NOT NULL' }

  # User variable is set to nil to disable controls in broadcasted posts. _post
  # and post/controls partial both depend on knowing who the current user is,
  # but based on current implementation of Turbo Streams (which wraps the
  # broadcasts for Active Job), there isn't a way to pass current_user to these
  # partials effectively.
  after_create_commit :broadcast_prepend_comment
  after_update_commit :broadcast_update_comment
  after_destroy_commit :broadcast_remove_comment

  private

  def broadcast_prepend_comment
    broadcast_append_later_to [Current.user, 'posts'],
                              target: "#{dom_id(post)}_comments",
                              locals: { current_user: nil }
  end

  def broadcast_update_comment
    broadcast_replace_later_to [Current.user, 'posts'],
                               target: "#{dom_id(post)}_#{dom_id(self)}",
                               locals: { current_user: nil }
  end

  def broadcast_remove_comment
    broadcast_remove_to [Current.user, 'posts'],
                        target: "#{dom_id(post)}_#{dom_id(self)}"
  end
end
