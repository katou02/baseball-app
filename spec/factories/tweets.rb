FactoryBot.define do
  factory :tweet do
    id { 1 }
    title { "テスト" }
    school_a_score { 1 }
    school_b_score { 2 }
    text {"テキスト"}
    round {"1回戦"}
    association :school_a,factory: :category
    association :school_b,factory: :category_2
    association :tournament,factory: :tournament
    association :user,factory: :user
  end
end