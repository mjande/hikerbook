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

    with

    expect(friend.friends).to include(user)

    # TODO: Figure out why this clause fails. The friends association works in
    # the model tests, and it works from the other direction, but for an unknown
    # reason this one comes back empty. Either discover cause or refactor to a
    # way that still captures behaviour but also passes.
    expect(user.friends).to include(friend)
  end
end
