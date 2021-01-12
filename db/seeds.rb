# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(name: "中野さん",
              email: "sample_admin@email.com",
              password: "password",
              password_confirmation: "password")

puts "Admin Created"

10.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password)
end

puts "User Created"

10.times do |n|
  name  = Faker::Name.name
  email = "sample#{n+1}@email.com"
  password = "password"
  Owner.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password,
                address: "東京都港区1-#{n}-1"
               )
end

puts "Owner Created"

Question.create!(detail: "さぶすくとは",
  answer: "さぶすくページ"
  )
Question.create!(detail: "ぷらん",
  answer: "お金欲しい"
  )
puts "Question Created"

Map.create!(address: "伊豆急下田駅")
puts "Map Created"

Category.create!(name: "和食",
                image_category: "https://cdn.pixabay.com/photo/2017/01/06/16/46/sushi-1958247__480.jpg"
                )

Category.create!(name: "定食",
                image_category: "https://media.istockphoto.com/photos/traditional-japanese-cuisine-picture-id1179688514?b=1&k=6&m=1179688514&s=170667a&w=0&h=BQPXTUoypII1Vkt7YdZph43vE1GvRIoVU-06r5FpUB4="
                )

Category.create!(name: "らーめん",
                image_category: "https://cdn.pixabay.com/photo/2018/03/15/10/33/bars-ramen-in-saigon-3227779__480.jpg"
                )
Category.create!(name: "カフェ",
                image_category: "https://media.gettyimages.com/photos/cup-of-latte-on-wooden-table-picture-id1035061554?k=6&m=1035061554&s=612x612&w=0&h=R5v_cne68naf73GAyFhFq54aUiD5hMd5x6lh_KQ_c0g="
                )
Category.create!(name: "パン屋",
                image_category: "https://cdn.pixabay.com/photo/2017/04/26/11/03/bread-2262333__480.jpg"
                )
Category.create!(name: "居酒屋",
                image_category: "https://cdn.pixabay.com/photo/2019/11/15/10/05/stalls-4628091__480.jpg"
                )
Category.create!(name: "イタリアン",
                image_category: "https://cdn.pixabay.com/photo/2020/06/08/16/49/pizza-5275191__480.jpg"
                )
Category.create!(name: "中華",
                image_category: "https://media.gettyimages.com/photos/dim-sum-picture-id839958568?k=6&m=839958568&s=612x612&w=0&h=J6WOpiwMZofS02B_EYhYU8FjBjBG619qMpY99K_oDFM="
                )
Category.create!(name: "フレンチ",
                image_category: "https://cdn.pixabay.com/photo/2016/12/09/04/15/scotland-1893646__480.jpg"
                )
Category.create!(name: "ハワイアン",
                image_category: "https://media.gettyimages.com/photos/raw-fish-sushi-pokebowl-meal-with-red-napkin-picture-id665627062?k=6&m=665627062&s=612x612&w=0&h=HesE-dNsbnmgKyTimQoMRiyYuZhwvSvUw920CrRE5fw="
                )
Category.create!(name: "東南アジア",
                image_category: "https://media.gettyimages.com/photos/nasi-goreng-famous-indonesian-food-picture-id1187617921?k=6&m=1187617921&s=612x612&w=0&h=7eNOTVc4tmUj-IWizG2qTLB01mEus84XqlLL9H0ybtk="
                )
Category.create!(name: "バー",
                image_category: "https://media.gettyimages.com/photos/bar-picture-id183760198?k=6&m=183760198&s=612x612&w=0&h=w2Yn7MIx2H_VWiV8A4RUrqB_FJsYwgs9hSE4W8WCB4o="
                )
Category.create!(name: "ケーキ",
                image_category: "https://cdn.pixabay.com/photo/2018/05/01/18/21/eclair-3366430__480.jpg"
                )
Category.create!(name: "焼肉",
                image_category: "https://media.istockphoto.com/photos/top-view-of-premium-rare-slices-many-parts-of-wagyu-a5-beef-with-on-picture-id1169410279?b=1&k=6&m=1169410279&s=170667a&w=0&h=CiQvMWUK7x73uERbummOpcLLwGYPt1W9Xi2VahlrYhE="
                )
Category.create!(name: "洋食",
                image_category: "https://cdn.pixabay.com/photo/2016/10/23/05/40/restaurant-1762236__480.jpg"
                )
Category.create!(name: "カレー",
                image_category: "https://media.istockphoto.com/photos/curry-rice-on-the-table-picture-id1066427100?b=1&k=6&m=1066427100&s=170667a&w=0&h=afrJvnBbrXqxUZMwtkJUeMbqenBy5YyaajWa2j-UsBk="
                )
Category.create!(name: "ハンバーガー",
                image_category: "https://media.gettyimages.com/photos/burger-picture-id1055177264?k=6&m=1055177264&s=612x612&w=0&h=Tv_R4cXvQzvPbNzKJ0C_1kyq7d19yKkMBDb07rHjIZk="
                )
Category.create!(name: "韓国料理",
                image_category: "https://media.gettyimages.com/photos/closeup-of-food-served-in-containers-on-table-picture-id946283686?k=6&m=946283686&s=612x612&w=0&h=mOwQbGo_7NxPAtPigtqOmZ5boZqWXkajmKzebPt_Qak="
                )
Category.create!(name: "レストラン",
                image_category: "https://media.gettyimages.com/photos/cafebar-in-moscow-picture-id1158221681?k=6&m=1158221681&s=612x612&w=0&h=JykZfmjm8VJtSMBVstQP3UP4Vp0Of7t-VokP63NSnXo="
                )
Category.create!(name: "お好み焼き",
                image_category: "istockphoto-95396899-170667a.jpg"
                )
Category.create!(name: "鍋",
                image_category: "korean-4147335__340.jpg"
                )
Category.create!(name: "スイーツ",
                image_category: "sweets.jpeg"
                )
Category.create!(name: "唐揚げ",
                image_category: "karaage.jpeg"
                )
Category.create!(name: "餃子",
                image_category: "gyouza.jpeg"
                )
Category.create!(name: "丼モノ",
                image_category: "don.jpeg"
                )
Category.create!(name: "うどん",
                image_category: "udon.jpeg"
                )
Category.create!(name: "そば",
                image_category: "soba.jpeg"
                )
Category.create!(name: "その他",
                image_category: "https://media.gettyimages.com/photos/eating-tasty-food-favorite-meal-picture-id931464590?k=6&m=931464590&s=612x612&w=0&h=nqB6QF0fsmtiYAgb2rmBRixQowzXHe42KWSqMeIUB7g="
                )
puts "Category Created"
