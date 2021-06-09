FactoryBot.define do
  factory :comment do
    id {1}
    text { "テキスト" }
    association :tweet,factory: :tweet
    association :user,factory: :user
  end
end