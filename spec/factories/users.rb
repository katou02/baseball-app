FactoryBot.define do
  factory :user,class: User do
    id { 20 }
    nickname { "test" }
    text {"自己紹介"}
    email { "test1@gmail.com" }
    password { "test2020" }
    password_confirmation { "test2020" }
  end
end