# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'delete post', type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
    user.posts.create(body: 'Original post')
    visit posts_path
  end

  it 'successfully deletes post' do
    click_on 'Delete'
    
    expect(page).not_to have_content('Original post')
  end
end