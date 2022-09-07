FactoryBot.define do
  factory :post do
    association :user
    description { 'Test' }
  end
end