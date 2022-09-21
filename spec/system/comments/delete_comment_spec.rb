# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'add comment', type: :system do
  include ActionView::RecordIdentifier

  let!(:user) { create(:user) }
  let!(:post) { create(:post) }
  let!(:comment) { create(:comment) }

  it 'successfully deletes comment' do
    expect(Comment.count).to eq(0)

    sign_in user
    visit posts_path

    within(dom_id(comment)) do
      click_on 'Delete'
    end

    expect(page).to have_content('Comment successfully deleted')
  end
end