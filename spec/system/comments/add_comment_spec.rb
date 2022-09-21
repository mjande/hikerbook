# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'add comment', type: :system do
  include ActionView::RecordIdentifier

  let!(:user) { create(:user) }
  let!(:post) { create(:post) }

  context 'with valid inputs' do
    it 'adds comments to post' do
      expect(Comment.count).to eq(0)

      sign_in user
      visit posts_path

      within(dom_id(post)) do
        expect(page).to have_content('Example Trail')
        click_on 'Comment'
        fill_in 'This is a comment example'
        click on 'Submit'
        expect(page).to have_content('This is a comment example')
      end

      expect(Comment.count).to eq(1)
    end
  end

  context 'with invalid inputs' do
    it 'does not create comment and displays error message' do
      expect(Comment.count).to eq(0)

      sign_in user
      visit posts_path

      within(dom_id(post)) do
        expect(page).to have_content('Example Trail')
        click_on 'Comment'
        click on 'Submit'
        expect(page).to have_content("Comment body can't be blank!")
      end

      expect(Comment.count).to eq(1)
    end
  end
end
