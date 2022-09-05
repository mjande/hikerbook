# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'update post', type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
    user.posts.create(body: 'Original post')
  end

  context 'with valid inputs' do
    it 'updates successfully' do
      click_on 'Edit post'
      within('h1') do
        expect(page).to have_content('Edit post')
      end

      fill_in 'post_body', with: 'Updated post'
      click_on 'Update post'

      within('h1') do
        expect(page).to have_content('Posts')
      end
      expect(page).to have_content('Updated post')
    end
  end
end
