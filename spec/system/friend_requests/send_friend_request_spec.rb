# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'send friend request', type: :system do
  include ActionView::RecordIdentifier

  let!(:user) { create(:user) }
  let!(:friend) { User.create(username: 'Friend', email: 'friend@example.com', password: 'password') }

  it 'successfully sends friend request' do
    sign_in user
    visit users_path

    within("##{dom_id(friend)}") do
      click_on 'Send Friend Request'
    end

    request = FriendRequest.new(sender: user, potential_friend: friend)
    expect(user.friend_requests.first).to eq(request)
  end
end
