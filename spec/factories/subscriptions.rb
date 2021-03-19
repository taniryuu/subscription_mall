FactoryBot.define do
  factory :subscription do
    name { "テスト店" }
    title { "" }
    detail { "" }
    owner
  end
end
