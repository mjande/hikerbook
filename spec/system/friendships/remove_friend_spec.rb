# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'remove friend', type: :system do
  include ActionView::RecordIdentifier

  let!(:user) { create(:user) }
  let!(:friend) { create(:user, username: 'Friend', email: 'friend@example.com') }

  it 'removes friendship between the users' do
    Friendship.create(user1: user, user2: friend)

    sign_in user
    visit users_path

    within("##{dom_id(friend)}") do
      click_on 'Remove Friend'
    end

    expect(page).to have_content('You are no longer friends!')
    expect(user.friendship_with(friend)).to be_falsey
  end
end
