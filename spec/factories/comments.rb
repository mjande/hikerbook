FactoryBot.define do
  factory :comment do
    user factory: :friend
    post factory: :commenter
    body { 'This is an comment example' }
  end
end
