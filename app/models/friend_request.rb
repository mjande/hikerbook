class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :potential_friend, class_name: 'User'

  validates :sender, uniqueness: { scope: :potential_friend }
end
