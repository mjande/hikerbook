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
