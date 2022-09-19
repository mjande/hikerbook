# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'liking post', type: :system do
  include ActionView::RecordIdentifier

  let!(:user) { create(:user) }
  let!(:friend) { create(:user, username: 'Friend', email: 'friend@example.com') }

  it 'adds one like to like count' do
    Friendship.create(user1: user, user2: friend)
    post = friend.posts.build(trail: 'Blue Loop', park: 'Example NP', description: 'Sample text')
    
    sign_in user
    within("##{dom_id(post)}") do
      expect(find('#likes').content).to eq(0)
      click_on 'Like'
      expect(find('#likes').content).to eq(1)
    end
  end
end