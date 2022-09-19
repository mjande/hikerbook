# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'liking post', type: :system do
  include ActionView::RecordIdentifier

  let!(:user) { create(:user) }
  let!(:friend) { create(:user, username: 'Friend', email: 'friend@example.com') }

  it 'adds one like to like count' do
    Friendship.create(user1: user, user2: friend)
    post = friend.posts.create(trail: 'Blue Loop', park: 'Example NP', description: 'Sample text')
    expect(post.likes.count).to eq(0)

    sign_in user
    visit posts_path

    within("##{dom_id(post)}_controls") do
      expect(page).to have_content('0 Likes')

      click_on 'like'
      expect(page).to have_content('1 Like')
    end

    expect(post.likes.count).to eq(1)
  end
end
