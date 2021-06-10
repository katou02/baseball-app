FactoryBot.define do
  factory :comment_forecast do
    id {1}
    text { "テキスト" }
    association :forecast,factory: :forecast
    association :user,factory: :user
  end
end