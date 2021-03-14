# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20210306095519) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "kana"
    t.string "line_id"
    t.string "address"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "blogs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.text "body"
    t.string "image_photo"
    t.bigint "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_blogs_on_admin_id"
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "image_category"
    t.string "search"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_private_stores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "category_id"
    t.integer "private_store_id"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_private_stores_on_category_id"
    t.index ["private_store_id"], name: "index_category_private_stores_on_private_store_id"
  end

  create_table "category_subscriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "category_id"
    t.integer "subscription_id"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_subscriptions_on_category_id"
    t.index ["subscription_id"], name: "index_category_subscriptions_on_subscription_id"
  end

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.string "subject"
    t.string "message"
    t.bigint "user_id"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_contacts_on_owner_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "subscription_id", null: false
    t.string "subscription_image", null: false
    t.text "comment"
    t.datetime "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "private_store_id"
    t.index ["private_store_id"], name: "index_images_on_private_store_id"
  end

  create_table "instablogs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "content"
    t.bigint "subscription_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "insta_content"
    t.index ["subscription_id"], name: "index_instablogs_on_subscription_id"
  end

  create_table "interviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "owner_name"
    t.string "shop_name"
    t.string "content"
    t.string "image_interview"
    t.string "youtube_url"
    t.string "music"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_interviews_on_owner_id"
  end

  create_table "media", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "media_name"
    t.string "media_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "megurumereviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "content"
    t.integer "score"
    t.float "rate", limit: 24
    t.string "image_id"
    t.string "email"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_megurumereviews_on_user_id"
  end

  create_table "owners", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "phone_number"
    t.string "store_information"
    t.string "payee"
    t.string "line_id"
    t.string "address"
    t.datetime "deleted_at"
    t.text "message"
    t.string "subject"
    t.string "kana"
    t.string "uid"
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true
  end

  create_table "private_store_instablogs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "content"
    t.bigint "private_store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "insta_content"
    t.index ["private_store_id"], name: "index_private_store_instablogs_on_private_store_id"
  end

  create_table "private_store_user_plans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "customer_id", null: false
    t.integer "private_store_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_private_store_user_plans_on_user_id"
  end

  create_table "private_stores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "title"
    t.text "detail"
    t.string "image_private_store"
    t.integer "price"
    t.text "private_store_detail"
    t.integer "shop_id"
    t.string "script"
    t.string "image_private_store2"
    t.string "image_private_store3"
    t.string "image_private_store4"
    t.string "image_private_store5"
    t.string "sub_image"
    t.string "sub_image2"
    t.string "sub_image3"
    t.string "sub_image4"
    t.string "sub_image5"
    t.string "sub_image6"
    t.string "sub_image7"
    t.string "sub_image8"
    t.string "sub_image9"
    t.string "sub_image10"
    t.string "sub_image11"
    t.string "sub_image12"
    t.integer "category_genre"
    t.text "blog"
    t.text "shop_introduction"
    t.string "qr_image"
    t.text "address"
    t.float "latitude", limit: 24
    t.float "longitude", limit: 24
    t.bigint "owner_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "insta_blog"
    t.boolean "recommend", default: true
    t.integer "category_private_stores_id"
    t.index ["owner_id"], name: "index_private_stores_on_owner_id"
    t.index ["user_id"], name: "index_private_stores_on_user_id"
  end

  create_table "questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "detail"
    t.text "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "content"
    t.integer "score"
    t.float "rate", limit: 24
    t.string "image_id"
    t.string "email"
    t.bigint "subscription_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "private_store_id"
    t.index ["private_store_id"], name: "index_reviews_on_private_store_id"
    t.index ["subscription_id"], name: "index_reviews_on_subscription_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "subscription_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "subscription_id"
    t.integer "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id"], name: "index_subscription_images_on_image_id"
    t.index ["subscription_id"], name: "index_subscription_images_on_subscription_id"
  end

  create_table "subscriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "title"
    t.text "detail"
    t.string "image_subscription"
    t.integer "price"
    t.text "subscription_detail"
    t.string "script"
    t.string "sub_image"
    t.string "sub_image2"
    t.string "sub_image3"
    t.string "sub_image4"
    t.string "sub_image5"
    t.string "sub_image6"
    t.string "sub_image7"
    t.string "sub_image8"
    t.string "sub_image9"
    t.string "sub_image10"
    t.string "sub_image11"
    t.string "sub_image12"
    t.text "blog"
    t.text "shop_introduction"
    t.string "qr_image"
    t.text "address"
    t.float "latitude", limit: 24
    t.float "longitude", limit: 24
    t.bigint "owner_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "insta_blog"
    t.boolean "recommend", default: true
    t.integer "category_subscriptions_id"
    t.index ["owner_id"], name: "index_subscriptions_on_owner_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "suports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.string "subject"
    t.string "message"
    t.bigint "user_id"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_suports_on_owner_id"
    t.index ["user_id"], name: "index_suports_on_user_id"
  end

  create_table "ticket_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date "use_ticket_day_log"
    t.bigint "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "owner_name"
    t.string "owner_email"
    t.string "owner_phone_number"
    t.string "owner_store_information"
    t.string "subscription_name"
    t.string "private_store_name"
    t.string "subscription_fee"
    t.date "issue_ticket_day"
    t.bigint "user_id"
    t.index ["ticket_id"], name: "index_ticket_logs_on_ticket_id"
  end

  create_table "tickets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "owner_name"
    t.string "owner_email"
    t.string "owner_phone_number"
    t.string "owner_store_information"
    t.string "owner_payee"
    t.string "subscription_name"
    t.string "private_store_name"
    t.string "subscription_fee"
    t.date "use_ticket_day"
    t.date "issue_ticket_day"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "trial_count"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "kana"
    t.string "line_id"
    t.string "address"
    t.float "latitude", limit: 24
    t.float "longitude", limit: 24
    t.string "phone_number"
    t.string "uid"
    t.string "provider"
    t.text "message"
    t.string "subject"
    t.string "session_id"
    t.integer "subscription_id"
    t.boolean "sms_auth", default: false, null: false
    t.string "customer_id", default: "", null: false
    t.date "use_ticket_day"
    t.date "issue_ticket_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_price"
    t.integer "session_price"
    t.integer "private_store_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "blogs", "admins"
  add_foreign_key "contacts", "owners"
  add_foreign_key "contacts", "users"
  add_foreign_key "images", "private_stores"
  add_foreign_key "instablogs", "subscriptions"
  add_foreign_key "interviews", "owners"
  add_foreign_key "megurumereviews", "users"
  add_foreign_key "private_store_instablogs", "private_stores"
  add_foreign_key "private_store_user_plans", "users"
  add_foreign_key "private_stores", "owners"
  add_foreign_key "private_stores", "users"
  add_foreign_key "reviews", "private_stores"
  add_foreign_key "reviews", "subscriptions"
  add_foreign_key "reviews", "users"
  add_foreign_key "subscriptions", "owners"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "suports", "owners"
  add_foreign_key "suports", "users"
  add_foreign_key "ticket_logs", "tickets"
  add_foreign_key "tickets", "users"
end
