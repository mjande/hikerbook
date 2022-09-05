# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'create post spec', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit posts_url
    click_on 'New post'
  end

  context 'with valid inputs' do
    it 'successfully saves post' do
      within('h1') do
        expect(page).to have_content('New Post')
      end

      fill_in 'post_body',	with: 'Test'
      click_on 'Create Post'

      expect(page).to have_content('Posts')
      expect(page).to have_content('Test')
    end
  end

  context 'with invalid inputs' do
    it 'does not save and displays error messages' do
      within('h1') do
        expect(page).to have_content('New Post')
      end

      click_on 'Create Post'

      expect(page).to have_content('New Post')
      expect(page).to have_content("Body can't be blank")
    end
  end
end

"test"