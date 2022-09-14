# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'accept friend request', type: :system do
  include ActionView::RecordIdentifier

  let!(:user) { create(:user) }
  let!(:friend) { create(:user, username: 'Friend', email: 'friend@example.com') }

  it 'adds friendship and deletes friend request' do
    FriendRequest.create(sender_id: friend.id, receiver_id: user.id)

    sign_in user
    visit users_path

    within("##{dom_id(friend)}") do
      click_on 'Add Friend'
    end

    expect(friend.friends).to include(user)
    expect(user.reload.friends).to include(friend)
    

    within("##{dom_id(friend)}") do
      expect(page).to have_content('Friends')
    end
  end
end
