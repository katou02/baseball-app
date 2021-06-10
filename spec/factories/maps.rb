FactoryBot.define do
  factory :map do
    id {1}
    text {"テスト"}
    address {"鳥取市"}
    latitude {35.5011}
    longitude {134.235}
    association :school,factory: :category
    association :tournament,factory: :tournament
    association :user,factory: :user
  end
end
