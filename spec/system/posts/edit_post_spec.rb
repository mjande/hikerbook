# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'update post', type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
    user.posts.create(trail: 'Original trail', park: 'Original park', description: 'Original post')
    visit posts_path
  end

  context 'with valid inputs' do
    it 'updates successfully' do
      click_on 'Edit'
      expect(page).to have_content('Edit Post')
      expect(page).to have_content('Original post')

      fill_in 'post_description', with: 'Updated post'
      click_on 'Update Post'

      expect(page).not_to have_content('Original post')
      expect(page).to have_content('Updated post')
    end
  end

  context 'with invalid inputs' do
    it 'does not update and displays error message' do
      click_on 'Edit'
      within('h1') do
        expect(page).to have_content('Edit Post')
      end

      fill_in 'post_park', with: ''
      click_on 'Update Post'

      expect(page).to have_content('Edit')
      expect(page).to have_content("Park can't be blank")
    end
  end
end
