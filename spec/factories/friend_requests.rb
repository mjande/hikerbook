FactoryBot.define do
  factory :friend_request do
    sender factory: :friend
    receiver factory: :user
  end
end