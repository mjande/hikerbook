require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it { should belong_to(:user1) }
  it { should belong_to(:user2) }

  it 'deletes friend request upon creation' do
    request = create(:friend_request)
    friendship = described_class.create(user1_id: request.receiver_id, user2_id: request.sender_id)

    request = FriendRequest.find_by(sender: friendship.user2, receiver: friendship.user1)
    expect(request).to be_falsey
  end
end
