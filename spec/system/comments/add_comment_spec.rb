# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'add comment', type: :system do
  include ActionView::RecordIdentifier

  let!(:commenter) { create(:commenter) }
  let!(:post) { create(:post) }

  before do
    Friendship.create(user1: commenter, user2: post.user)
  end

  context 'with valid inputs' do
    it 'adds comments to post' do
      expect(Comment.count).to eq(0)

      sign_in commenter
      visit post_path(post)

      within("##{dom_id(post)}") do
        expect(page).to have_content('Example Trail')
        click_on 'Leave a comment'
      end

      fill_in 'comment[body]', with: 'This is a comment example'
      click_on 'Submit'
      expect(page).to have_content('This is a comment example')
      expect(Comment.count).to eq(1)
    end
  end

  context 'with invalid inputs' do
    it 'does not create comment and displays error message' do
      expect(Comment.count).to eq(0)

      sign_in commenter
      visit post_path(post)

      within("##{dom_id(post)}") do
        expect(page).to have_content('Example Trail')
        click_on 'Leave a comment'
      end

      click_on 'Submit'
      expect(page).to have_content("Body can't be blank")
      expect(Comment.count).to eq(0)
    end
  end
end
