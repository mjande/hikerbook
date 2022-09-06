# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'delete post', type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
    user.posts.create(trail: 'Original trail', park: 'Original park', body: 'Original post')
    visit posts_path
  end

  it 'successfully deletes post' do
    expect(page).to have_content('Original post')
    click_on 'Delete'

    expect(page).not_to have_content('Original post')
  end
end
