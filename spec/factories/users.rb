FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    email { "user1@example.com" }
    password { "password1" }
  end
end
