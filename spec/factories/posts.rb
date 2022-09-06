FactoryBot.define do
  factory :post do
    association :user
    body { 'Test' }
  end
end