FactoryBot.define do
  factory :post do
    association :user
    trail { 'Example Loop' }
    park { 'Example National Park' }
    description { 'Test' }
  end
end