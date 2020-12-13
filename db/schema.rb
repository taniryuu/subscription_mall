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

ActiveRecord::Schema.define(version: 20201212071841) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "kana"
    t.string "line_id"
    t.string "address"
    t.string "phone_number"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "image_photo"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_blogs_on_admin_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "genre"
    t.string "image_category"
    t.index ["owner_id"], name: "index_categories_on_owner_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "subject"
    t.string "message"
    t.integer "user_id"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_contacts_on_owner_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "cupons", force: :cascade do |t|
    t.string "product"
    t.string "discount"
    t.integer "status"
    t.string "image"
    t.string "writing"
    t.integer "limit"
    t.text "reason"
    t.integer "review_id"
    t.integer "owner_id"
    t.integer "user_id"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_cupons_on_admin_id"
    t.index ["owner_id"], name: "index_cupons_on_owner_id"
    t.index ["review_id"], name: "index_cupons_on_review_id"
    t.index ["user_id"], name: "index_cupons_on_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "image_subscription_id"
    t.string "image_interview_id"
    t.text "comment"
    t.datetime "time"
    t.integer "user_id"
    t.integer "owner_id"
    t.integer "subscription_id"
    t.integer "interview_id"
    t.integer "blog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_id"], name: "index_images_on_blog_id"
    t.index ["interview_id"], name: "index_images_on_interview_id"
    t.index ["owner_id"], name: "index_images_on_owner_id"
    t.index ["subscription_id"], name: "index_images_on_subscription_id"
    t.index ["user_id"], name: "index_images_on_user_id"
  end

  create_table "interviews", force: :cascade do |t|
    t.string "owner_name"
    t.string "shop_name"
    t.string "content"
    t.string "image_interview"
    t.string "youtube_url"
    t.string "music"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_interviews_on_owner_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["email"], name: "index_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "price"
    t.text "subscription_detail"
    t.integer "subscription_id"
    t.integer "owner_id"
    t.integer "user_id"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_products_on_admin_id"
    t.index ["owner_id"], name: "index_products_on_owner_id"
    t.index ["subscription_id"], name: "index_products_on_subscription_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "detail"
    t.text "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string "name"
    t.string "content"
    t.integer "score"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "rate"
    t.string "image_id"
    t.string "email"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "category_name"
    t.integer "monthly_fee"
    t.string "phone_number"
    t.string "store_information"
    t.string "payee"
    t.string "line_id"
    t.string "address"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_shops_on_owner_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.text "detail"
    t.string "image_subscription"
    t.integer "price"
    t.text "subscription_detail"
    t.integer "category_name"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shop_id"
    t.string "script"
    t.string "image_subscription2"
    t.string "image_subscription3"
    t.string "image_subscription4"
    t.integer "category_genre"
    t.index ["owner_id"], name: "index_subscriptions_on_owner_id"
  end

  create_table "suports", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "subject"
    t.string "message"
    t.integer "user_id"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_suports_on_owner_id"
    t.index ["user_id"], name: "index_suports_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
