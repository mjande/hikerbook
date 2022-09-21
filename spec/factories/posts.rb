FactoryBot.define do
  factory :post do
    user factory: :friend
    trail { 'Example Trail' }
    park { 'Example National Park' }
    description { 'This is an example.' }
  end
end
