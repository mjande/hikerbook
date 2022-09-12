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
    let(:friend1) { create(:user, username: 'Friend #1', email: 'friend1@example.com') }
    let(:friend2) { create(:user, username: 'Friend #2', email: 'friend2@example.com') }

    before do
      Friendship.create(user:, friend: friend1)
      Friendship.create(user:, friend: friend2)
    end

    it 'returns an array of all current friends' do
      expect(user.friends).to include(friend1, friend2)
    end
  end

  describe '#sent_request?' do
    let(:friend) { create(:user, username: 'Friend', email: 'friend@example.com') }

    it 'returns true if the current user has already sent a request to that user' do
      FriendRequest.create(sender: user, receiver: friend)
      expect(user).to be_sent_request(friend)
    end

    it 'returns false if the current user has not sent a request to that user' do
      expect(user).not_to be_sent_request(friend)
    end
  end

  describe '#received_request?' do
    let(:friend) { create(:user, username: 'Friend', email: 'friend@example.com') }

    it 'returns true if the current user received a request from that user' do
      FriendRequest.create(sender: friend, receiver: user)
      expect(user).to be_received_request(friend)
    end

    it 'returns false if the current user has not received a request from that user' do
      expect(user).not_to be_received_request(friend)
    end
  end
end
