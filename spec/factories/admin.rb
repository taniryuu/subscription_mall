FactoryBot.define do
  factory :admin do
    name { "テスト管理者" }
    email { "admin@example.com" }
    password { "password1" }
  end
end
