class Park < ApplicationRecord
  validates :name, presence: true
  has_one_attached :image do |attachable|
    attachable.variant :sidebar, resize_to_fill: [320, 180]
  end
end
