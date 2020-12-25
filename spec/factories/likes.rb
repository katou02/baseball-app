FactoryBot.define do
  factory :like do
    association :tweet,factory: :tweet
    association :user,factory: :user
  end
end