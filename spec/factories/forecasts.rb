FactoryBot.define do
  factory :forecast do
    id { 1 }
    text { "テキスト" }
    round { "1回戦" }
    probability {"80%"}
    association :win_school,factory: :category
    association :lose_school,factory: :category_2
    association :tournament,factory: :tournament
    association :user,factory: :user
  end
end