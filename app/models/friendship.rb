# frozen_string_literal: true

# The Friendship model represents a relationship between two users. Friends can
# see each other's posts, like each other's posts, and leave comments on them.
class Friendship < ApplicationRecord
  after_create :destroy_friend_request

  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'

  def destroy_friend_request
    # This method assumes that the original sender of the friend request is
    # user2, and the responder is user1. This is based on the way the
    # friendships controller handles record creation.
    friend_request = FriendRequest.find_by sender_id: user2, receiver_id: user1
    return unless friend_request

    friend_request.destroy
  end
end
