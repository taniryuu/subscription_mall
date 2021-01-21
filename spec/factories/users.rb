FactoryBot.define do
  factory :user do
    name {"Sample"}
    sequence(:email) { |n| "tester#{n}@email.com" }
    password {"password"}
  end
end