FactoryBot.define do
  factory :comment do
    user factory: :commenter
    post
    body { 'This is a comment example' }
  end
end
