class Comment < ApplicationRecord
  include ActionView::RecordIdentifier # to use dom_id method

  belongs_to :user
  belongs_to :post

  validates :body, presence: true, length: { maximum: 140 }

  scope :persisted, -> { where 'id IS NOT NULL' }

  after_create_commit :broadcast_prepend_comment
  after_update_commit :broadcast_update_comment
  after_destroy_commit :broadcast_remove_comment

  def to_dom_id
    "#{dom_id(post)}_#{dom_id(self)}"
  end

  private

  def broadcast_prepend_comment
    Current.user.friends.each do |friend|
      broadcast_append_later_to friend,
                                target: "#{dom_id(post)}_comments",
                                locals: { user: friend }
    end
  end

  def broadcast_update_comment
    Current.user.friends.each do |friend|
      broadcast_replace_later_to friend,
                                 target: to_dom_id,
                                 locals: { user: friend }
    end
  end

  def broadcast_remove_comment
    Current.user.friends.each do |friend|
      broadcast_remove_to friend,
                          target: to_dom_id
    end
  end
end
