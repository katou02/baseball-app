FactoryBot.define do
  factory :message do
    id { 1 }
    body { "メッセージ" }
    association :user,factory: :user
    association :room,factory: :user
  end
end