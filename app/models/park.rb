# frozen_string_literal: true

# The Park class represents a national, state, or local park where other users
# might hike. Users can discover new parks by viewing the sidebar on their home
# page. There is no way for users to add parks to the database at this time.
class Park < ApplicationRecord
  validates :name, presence: true
  has_one_attached :image do |attachable|
    attachable.variant :sidebar, resize_to_fill: [320, 180]
  end
end
