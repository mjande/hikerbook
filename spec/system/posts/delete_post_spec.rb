# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'delete post', type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
    user.posts.create(trail: 'Original trail', park: 'Original park', description: 'Original post')
    visit posts_path
  end

  it 'successfully deletes post' do
    expect(Post.count).to eq(1)
    expect(page).to have_content('Original post')

    click_on 'delete'

    expect(page).not_to have_content('Original post')
    expect(Post.count).to eq(0)
  end
end
