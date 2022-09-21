FactoryBot.define do
  factory :user do
    username { 'Henry Test' }
    email { 'henry@example.com' }
    password { 'password' }
  end

  factory :friend, class: 'User' do
    username { 'Friend' }
    email { 'friend@example.com' }
    password { 'password' }
  end
end
