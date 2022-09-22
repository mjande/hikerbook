class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :body, presence: true, length: { maximum: 140 }

  scope :persisted, -> { where 'id IS NOT NULL' }
end
