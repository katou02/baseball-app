FactoryBot.define do
  factory :analysis do
    id { 1 }
    title {"タイトル"}
    text { "テキスト" }
    attack { 5 }
    defensive { 5 }
    pitcher { 5 }
    comprehensive { 5 }
    expectations { 5 }
    association :school,factory: :category
    association :tournament,factory: :tournament
    association :user,factory: :user
  end
end