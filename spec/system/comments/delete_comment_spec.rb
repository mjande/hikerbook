# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'delete comment', type: :system do
  include ActionView::RecordIdentifier

  let!(:comment) { create(:comment) }
  let(:commenter) { User.find_by(username: 'Commenter') }

  it 'successfully deletes comment' do
    Friendship.create(user1: commenter, user2: comment.post.user)

    expect(Comment.count).to eq(1)

    sign_in commenter
    visit posts_path

    within("##{dom_id(comment.post)}_#{dom_id(comment)}") do
      expect(page).to have_content('This is a comment example')
      click_on 'Delete'
    end

    expect(page).not_to have_content('This is a comment example')
    expect(Comment.count).to eq(0)
  end
end
