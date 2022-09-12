# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'reject friend request', type: :system do
  include ActionView::RecordIdentifier
  
  let!(:user) { create(:user) }
  let!(:friend) { User.create(username: 'Friend', email: 'friend@example.com', password: 'password') }
  let(:request) { FriendRequest.find_by(sender: friend) }

  it 'adds friendship and deletes friend request' do
    FriendRequest.create(sender_id: friend, receiver_id: user)

    sign_in user
    visit root_path

    within(dom_id(friend)) do
      click_on 'Add Friend'
    end

    expect(request).not_to exist
    expect(user.friends).to include(friend)
    expect(friend.friends).to include(user)
  end
end
