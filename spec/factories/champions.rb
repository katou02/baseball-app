FactoryBot.define do
  factory :champion do
    association :champion_school,factory: :category
    association :tournament,factory: :tournament
    association :user,factory: :user
  end
end