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

    expect(user.sent_requests.first).to have_attributes(sender_id: user.id, receiver_id: friend.id)
    expect(friend.received_requests.first).to have_attributes(sender_id: user.id, receiver_id: friend.id)

    expect(page).to have_content('Your friend request was sent!')

    sign_out user
    sign_in friend
    visit users_path

    within("##{dom_id(user)}") do
      expect(page).to have_content('Sent you a friend request!')
    end
  end
end
