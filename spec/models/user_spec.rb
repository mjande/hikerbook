# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_presence_of(:password) }
  it { should have_many(:posts) }

  it 'sends and email' do
    expect { user.save }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  describe 'friend_requests' do
    let(:requesting_friend) do
      create(:user, username: 'Requesting Friend',
                    email: 'requestingfriend@example.com')
    end
    let(:requested_friend) do
      create(:user, username: 'Requested Friend',
                    email: 'requestedfriend@example.com')
    end

    before do
      user.save
      FriendRequest.create(sender: requesting_friend, receiver: user)
      FriendRequest.create(sender: user, receiver: requested_friend)
    end

    describe '#requesting_friends' do
      it 'returns friends who have sent active friend requests' do
        expect(user.requesting_friends).to include(requesting_friend)
      end

      it 'does not return requests sent by the current user' do
        expect(user.requesting_friends).not_to include(requested_friend)
      end
    end

    describe '#requested_friends' do
      it 'returns friend to whom the current user has sent active friend requests' do
        expect(user.requested_friends).to include(requested_friend)
      end

      it 'does not return friend requests sent by other users' do
        expect(user.requested_friends).not_to include(requesting_friend)
      end
    end
  end

  describe '#friends' do
    let(:friend1) { create(:friend) }
    let(:friend2) { create(:user, username: 'Friend #2', email: 'friend2@example.com') }
    let(:friend3) { create(:user, username: 'Friend #3', email: 'friend3@example.com') }

    before do
      Friendship.create(user1: user, user2: friend1)
      Friendship.create(user1: user, user2: friend2)
    end

    it 'returns an array of all current friends' do
      expect(user.friends).to include(friend1, friend2)
    end

    it 'works in both directions' do
      expect(friend1.friends).to include(user)
    end

    it 'does not include users that are not friends' do
      expect(user.friends).not_to include(friend3)
    end
  end

  describe '#sent_request_to' do
    let(:friend) { create(:friend) }

    it 'returns request if the current user has already sent a request to that user' do
      request = FriendRequest.create(sender: user, receiver: friend)
      expect(user.sent_request_to(friend)).to eq(request)
    end

    it 'returns false if the current user has not sent a request to that user' do
      expect(user.sent_request_to(friend)).to be_falsey
    end
  end

  describe '#received_request_from' do
    let(:friend) { create(:friend) }

    it 'returns request if the current user received a request from that user' do
      request = FriendRequest.create(sender: friend, receiver: user)
      expect(user.received_request_from(friend)).to eq(request)
    end

    it 'returns false if the current user has not received a request from that user' do
      expect(user.received_request_from(friend)).to be_falsey
    end
  end

  describe '#friendship_with' do
    let(:friend) { create(:friend) }

    it 'returns friendship if current user (as user1) is friends with user' do
      friendship = Friendship.create(user1: user, user2: friend)
      expect(user.friendship_with(friend)).to eq(friendship)
    end

    it 'returns friendship if current user (as user2) is friends with user' do
      friendship = Friendship.create(user1: friend, user2: user)
      expect(user.friendship_with(friend)).to eq(friendship)
    end

    it 'returns false if current user is not friends with user' do
      expect(user.friendship_with(friend)).to be_falsey
    end
  end
end
