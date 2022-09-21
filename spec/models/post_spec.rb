# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of(:trail) }
  it { should validate_presence_of(:park) }
  it { should belong_to(:user) }

  describe '#liked_by?' do
    subject(:post) { create(:post) }

    let(:user) { create(:user) }

    it 'returns like if already liked by the user' do
      like = post.likes.create(user:)
      expect(post.liked_by(user)).to eq(like)
    end

    it 'returns false if the post has not been liked by the user' do
      expect(post.liked_by(user)).to be_falsey
    end
  end
end
