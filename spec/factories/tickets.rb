FactoryBot.define do
  factory :ticket do
    owner_name { "MyString" }
    owner_email { "MyString" }
    owner_phone_number { "MyString" }
    owner_store_information { "MyString" }
    owner_payee { "MyString" }
    subscription_name { "MyString" }
    subscription_fee { "MyString" }
    use_ticket_day { "2020-12-20" }
    user { nil }
  end
end
