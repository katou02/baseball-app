FactoryBot.define do
  factory :contact do
    name { "テストユーザー" }
    email { "test@gmail.com" }
    content { "テスト" }
  end
end