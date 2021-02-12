FactoryBot.define do
  factory :ticket_log do
    use_ticket_day_log { "2021-02-03" }
    ticket { nil }
  end
end
