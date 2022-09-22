class Comment < ApplicationRecord
  include ActionView::RecordIdentifier # to use dom_id method

  belongs_to :user
  belongs_to :post

  validates :body, presence: true, length: { maximum: 140 }

  scope :persisted, -> { where 'id IS NOT NULL' }

  after_create_commit -> { broadcast_append_later_to [Current.user, 'posts'], target: "#{dom_id(post)}_comments" }
  after_update_commit -> { broadcast_replace_later_to [Current.user, 'posts'], target: "#{dom_id(post)}_#{dom_id(self)}" }
  after_destroy_commit -> { broadcast_remove_to [Current.user, 'posts'], target: "#{dom_id(post)}_#{dom_id(self)}" }
end
