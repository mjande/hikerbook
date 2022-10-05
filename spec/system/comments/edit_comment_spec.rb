# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'edit comment', type: :system do
  include ActionView::RecordIdentifier

  let!(:comment) { create(:comment) }
  let(:user) { User.find_by(username: 'Commenter') }

  context 'with valid inputs' do
    it 'updates comments on post' do
      sign_in user
      visit post_path(comment.post)

      within("##{comment.to_dom_id}") do
        expect(page).to have_content('This is a comment example')
        click_on 'Edit'
        fill_in 'comment_body', with: 'This is an updated comment example'
        click_on 'Submit'
        expect(page).to have_content('This is an updated comment example')
      end
    end
  end

  context 'with invalid inputs' do
    it 'does not update comment and displays error message' do
      sign_in user
      visit post_path(comment.post)

      within("##{comment.to_dom_id}") do
        expect(page).to have_content('This is a comment example')
        click_on 'Edit'
        fill_in 'comment_body', with: ''
        click_on 'Submit'
        expect(page).to have_content("Body can't be blank")
      end
    end
  end
end
