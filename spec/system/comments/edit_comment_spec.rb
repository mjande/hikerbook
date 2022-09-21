# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'add comment', type: :system do
  include ActionView::RecordIdentifier

  let!(:user) { create(:user) }
  let!(:post) { create(:post) }
  let!(:comment) { create(:comment) }

  context 'with valid inputs' do
    it 'updates comments on post' do
      sign_in user
      visit posts_path
      
      within(dom_id(comment)) do
        expect(page).to have_content('This is a comment example')
        click_on 'Edit'
        fill_in 'This is an updated comment example'
        click_on 'Submit'
        expect(page).to have_content('This is an updated comment example')
      end
    end
  end

  context 'with invalid inputs' do
    it 'does not update comment and displays error message' do
      sign_in user
      visit posts_path
      
      within(dom_id(comment)) do
        expect(page).to have_content('This is a comment example')
        click_on 'Edit'
        click_on 'Submit'
        expect(page).to have_content("Comment body can't be blank")
      end
    end
  end
end