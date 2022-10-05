# frozen_string_literal: true

FactoryBot.define do
  factory :friendship do
    user1 factory: :user
    user2 factory: :friend
  end
end
