FactoryBot.define do
  factory :map do
    address { "MyText" }
    latitude { 1.5 }
    longitude { 1.5 }
    distance { 1 }
    near_distance { 1 }
    time { 1 }
    near_time { 1 }
    title { "MyText" }
    comment { "MyText" }
  end
end
