# frozen_string_literal: true

# The FriendRequest model represents a pending request for friendship between
# two users. The user who initiates the resquest is called the sender, while the
# one who will respond to it is called the receiver.
class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :sender, uniqueness: { scope: :receiver }

  after_commit :broadcast_update_notifications

  private

  def broadcast_update_notifications
    broadcast_update_later_to receiver,
                              target: 'friend_request_notifications',
                              partial: 'layouts/friend_request_notifications',
                              locals: { friend_request_count: receiver.received_requests.count }
  end
end
