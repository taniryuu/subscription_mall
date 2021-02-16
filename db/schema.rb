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

ActiveRecord::Schema.define(version: 20210213080214) do

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
    t.bigint "user_id"
    t.bigint "owner_id"
    t.string "genre"
    t.string "image_category"
    t.string "search"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_categories_on_owner_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
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
    t.string "image_subscription_id"
    t.string "image_interview_id"
    t.text "comment"
    t.datetime "time"
    t.bigint "user_id"
    t.bigint "owner_id"
    t.bigint "subscription_id"
    t.bigint "interview_id"
    t.bigint "blog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_id"], name: "index_images_on_blog_id"
    t.index ["interview_id"], name: "index_images_on_interview_id"
    t.index ["owner_id"], name: "index_images_on_owner_id"
    t.index ["subscription_id"], name: "index_images_on_subscription_id"
    t.index ["user_id"], name: "index_images_on_user_id"
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

  create_table "questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "detail"
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
    t.index ["subscription_id"], name: "index_reviews_on_subscription_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "subscriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "title"
    t.text "detail"
    t.string "image_subscription"
    t.integer "price"
    t.text "subscription_detail"
    t.integer "category_name"
    t.integer "shop_id"
    t.string "script"
    t.string "image_subscription2"
    t.string "image_subscription3"
    t.string "image_subscription4"
    t.string "image_subscription5"
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
    t.integer "monthly_fee"
    t.text "blog"
    t.text "shop_introduction"
    t.string "qr_image"
    t.text "address"
    t.float "latitude", limit: 24
    t.float "longitude", limit: 24
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "insta_blog"
    t.boolean "recommend", default: true
    t.bigint "category_id"
    t.index ["category_id"], name: "index_subscriptions_on_category_id"
    t.index ["owner_id"], name: "index_subscriptions_on_owner_id"
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
    t.string "subscription_fee"
    t.date "use_ticket_day"
    t.date "issue_ticket_day"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "user_plans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "customer_id", null: false
    t.integer "subscription_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_plans_on_user_id"
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
    t.string "phone_number"
    t.string "uid"
    t.string "provider"
    t.datetime "deleted_at"
    t.text "message"
    t.string "subject"
    t.string "session_id"
    t.integer "subscription_id"
    t.date "use_ticket_day"
    t.date "issue_ticket_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_price"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "blogs", "admins"
  add_foreign_key "categories", "owners"
  add_foreign_key "categories", "users"
  add_foreign_key "contacts", "owners"
  add_foreign_key "contacts", "users"
  add_foreign_key "images", "blogs"
  add_foreign_key "images", "interviews"
  add_foreign_key "images", "owners"
  add_foreign_key "images", "subscriptions"
  add_foreign_key "images", "users"
  add_foreign_key "instablogs", "subscriptions"
  add_foreign_key "interviews", "owners"
  add_foreign_key "megurumereviews", "users"
  add_foreign_key "reviews", "subscriptions"
  add_foreign_key "reviews", "users"
  add_foreign_key "subscriptions", "categories"
  add_foreign_key "subscriptions", "owners"
  add_foreign_key "suports", "owners"
  add_foreign_key "suports", "users"
  add_foreign_key "ticket_logs", "tickets"
  add_foreign_key "tickets", "users"
  add_foreign_key "user_plans", "users"
end
