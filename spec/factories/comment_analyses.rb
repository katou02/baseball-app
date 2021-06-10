FactoryBot.define do
  factory :comment_analysis do
    id {1}
    text { "テキスト" }
    association :analysis,factory: :analysis
    association :user,factory: :user
  end
end