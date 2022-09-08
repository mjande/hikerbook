# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_presence_of(:password) }
  it { should have_many(:posts) }

  it 'has friends through friendships table' do
    user.save
    friend = described_class.create(username: 'Friend', email: 'friend@example.com', password: 'password')
    user.friendships.create(friend:)
    expect(user.friends).to eq([friend])
  end
end
