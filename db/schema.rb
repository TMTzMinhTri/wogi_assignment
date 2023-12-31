# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_11_093156) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "products_count", default: 0
    t.string "website"
    t.boolean "is_published", default: true
    t.float "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["name"], name: "index_brands_on_name", unique: true
  end

  create_table "cards", force: :cascade do |t|
    t.string "activation_number", null: false
    t.datetime "deleted_at"
    t.string "pin"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.integer "quantity", default: 0, null: false
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activation_number"], name: "index_cards_on_activation_number"
    t.index ["deleted_at"], name: "index_cards_on_deleted_at"
    t.index ["product_id"], name: "index_cards_on_product_id"
  end

  create_table "product_access_controls", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "product_id"
    t.index ["product_id"], name: "index_product_access_controls_on_product_id"
    t.index ["user_id"], name: "index_product_access_controls_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "rating"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.bigint "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.boolean "is_published", default: true
    t.integer "cards_count"
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["is_published"], name: "index_products_on_is_published"
  end

  create_table "user_cards", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "card_id"
    t.datetime "deleted_at"
    t.datetime "cancelled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_user_cards_on_card_id"
    t.index ["user_id"], name: "index_user_cards_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "authenticate_token"
    t.integer "role", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_cards_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "product_access_controls", "products"
  add_foreign_key "product_access_controls", "users"
  add_foreign_key "products", "brands"
end
