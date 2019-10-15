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

ActiveRecord::Schema.define(version: 2019_10_14_105540) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "first_name_kana", null: false
    t.string "last_name_kana", null: false
    t.string "zip_code", null: false
    t.string "city", null: false
    t.string "street", null: false
    t.string "building", null: false
    t.string "phone_number_sub"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "prefecture_id", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "cards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "customer_id", null: false
    t.string "card_id", null: false
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "ancestry"
    t.string "name", null: false
    t.bigint "sizing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sizing_id"], name: "index_categories_on_sizing_id"
  end

  create_table "identifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "first_name_kana", null: false
    t.string "last_name_kana", null: false
    t.string "zip_code"
    t.string "city"
    t.string "street"
    t.string "building"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.date "birthday", null: false
    t.integer "prefecture_id"
    t.index ["user_id"], name: "index_identifications_on_user_id"
  end

  create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_images_on_item_id"
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "price", null: false
    t.string "name", null: false
    t.bigint "category_id"
    t.bigint "sizing_id"
    t.string "brand"
    t.text "description", null: false
    t.integer "condition", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand"], name: "index_items_on_brand"
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["condition"], name: "index_items_on_condition"
    t.index ["name"], name: "index_items_on_name"
    t.index ["price"], name: "index_items_on_price"
    t.index ["sizing_id"], name: "index_items_on_sizing_id"
  end

  create_table "sizings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "ancestry"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sns_confirmations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "email"
    t.index ["provider", "uid"], name: "index_sns_confirmations_on_provider_and_uid", unique: true
    t.index ["user_id"], name: "index_sns_confirmations_on_user_id"
  end

  create_table "transacts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "seller_id", null: false
    t.bigint "buyer_id"
    t.integer "delivery_method", null: false
    t.boolean "bearing", null: false
    t.integer "ship_days", null: false
    t.integer "status", default: 0, null: false
    t.integer "prefecture_id", null: false
    t.datetime "parchased_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_transacts_on_buyer_id"
    t.index ["item_id"], name: "index_transacts_on_item_id"
    t.index ["seller_id"], name: "index_transacts_on_seller_id"
  end

  create_table "upload_tests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname", null: false
    t.string "phone_number", null: false
    t.string "avator_image"
    t.text "profile"
    t.integer "card_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "cards", "users"
  add_foreign_key "categories", "sizings"
  add_foreign_key "identifications", "users"
  add_foreign_key "images", "items"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "sizings"
  add_foreign_key "sns_confirmations", "users"
  add_foreign_key "transacts", "items"
  add_foreign_key "transacts", "users", column: "buyer_id"
  add_foreign_key "transacts", "users", column: "seller_id"
end
