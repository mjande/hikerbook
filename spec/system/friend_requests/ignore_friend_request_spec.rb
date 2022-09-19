# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ignore friend request', type: :system do
  include ActionView::RecordIdentifier

  let!(:user) { create(:user) }
  let!(:friend) { User.create(username: 'Friend', email: 'friend@example.com', password: 'password') }

  it 'successfully deletes request' do
    FriendRequest.create(sender: friend, receiver: user)

    sign_in user
    visit users_path

    within("##{dom_id(friend)}") do
      click_on 'Ignore'
    end

    expect(page).to have_content('The friend request was ignored!')
    expect(user.received_request_from(friend)).to be_falsey
  end
end
