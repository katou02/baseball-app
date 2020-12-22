FactoryBot.define do
  factory :user,class: User do
    id { 1 }
    nickname { "test" }
    email { "test@gmail.com" }
    password { "test2020" }
    password_confirmation { "test2020" }
  end
end