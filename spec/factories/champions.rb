FactoryBot.define do
  factory :champion do
    id {1}
    association :champion_school,factory: :category
    association :tournament,factory: :tournament
    association :user,factory: :user
  end
end