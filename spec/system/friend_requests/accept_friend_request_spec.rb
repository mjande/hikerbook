# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'reject friend request', type: :system do
  let!(:user) { create(:user) }
  let!(:friend) { User.create(username: 'Friend', email: 'friend@example.com', password: 'password') }
  let(:request) { FriendRequest.find_by(sender: friend) }

  before do
    sign_in friend
    visit users_path

    within(".#{dom_id(user)}") do
      click_on 'Send Friend Request'
    end
    sign_out friend
  end

  it 'adds friendship and deletes friend request' do
    sign_in user
    visit root_path

    within(dom_id(request)) do
      click_on 'Add Friend'
    end

    expect(request).not_to exist
    expect(user.friends).to include(friend)
    expect(friend.friends).to include(user)
  end
end
