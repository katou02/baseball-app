FactoryBot.define do
  factory :user do
    nickname { "test" }
    email { "test@gmail.com" }
    password { "test2020" }
    password_confirmation { "test2020" }
  end
end