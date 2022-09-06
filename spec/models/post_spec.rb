require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  it 'is valid with valid attributes' do
    post = user.posts.build(body: 'test')
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    expect(described_class.new).not_to be_valid
  end

  it 'is not valid without a user' do
    post = described_class.new(body: 'test')
    expect(post).not_to be_valid
  end

  it 'belongs to a user' do
    post = user.posts.build(body: 'test')
    expect(post.user).to eq(user)
  end
end
