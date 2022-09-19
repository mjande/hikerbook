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

    expect(page).to have_content('Your friend request was sent!')

    sign_out user
    sign_in friend
    visit users_path

    within("##{dom_id(user)}") do
      expect(page).to have_content('Sent you a friend request!')
    end

    expect(user.sent_request_to(friend)).to be_truthy
    expect(friend.received_request_from(user)).to be_truthy
  end
end
