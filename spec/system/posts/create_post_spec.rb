# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'create post', type: :system do
  let(:user) { create(:user) }

  context 'with valid inputs' do
    it 'successfully saves post' do
      sign_in user
      visit posts_path

      click_on 'New post'
      within('h1') do
        expect(page).to have_content('New Post')
      end

      fill_in 'post[trail]', with: 'Blue Loop'
      fill_in 'post[park]', with: 'Olympic National Park'
      fill_in 'post[description]',	with: 'Trail description'
      click_on 'Create Post'

      within('.post') do
        expect(page).to have_content('Blue Loop')
        expect(page).to have_content('Olympic National Park')
        expect(page).to have_content('Trail description')
      end
    end
  end

  context 'with invalid inputs' do
    it 'does not save and displays error messages' do
      sign_in user
      visit posts_path

      click_on 'New post'
      within('h1') do
        expect(page).to have_content('New Post')
      end

      click_on 'Create Post'

      expect(page).to have_content('New Post')
      expect(page).to have_content("Trail can't be blank")
      expect(page).to have_content("Park can't be blank")
      expect(page).to have_content("Description can't be blank")
    end
  end
end
