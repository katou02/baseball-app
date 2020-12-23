FactoryBot.define do
  factory :comment_analysis do
    text { "テキスト" }
    association :analysis,factory: :analysis
    association :user,factory: :user
  end
end