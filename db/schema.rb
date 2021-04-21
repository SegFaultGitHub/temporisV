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

ActiveRecord::Schema.define(version: 2021_04_20_172634) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.integer "level", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "recipe_count", default: 0, null: false
    t.text "color", null: false
    t.boolean "super_card", default: false, null: false
    t.index ["color"], name: "index_cards_on_color"
    t.index ["name"], name: "index_cards_on_name", unique: true
    t.index ["super_card"], name: "index_cards_on_super_card"
  end

  create_table "items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "item_type", null: false
    t.integer "level", default: 0, null: false
    t.integer "recipe_count", default: 0, null: false
    t.text "type", null: false
    t.index ["name", "type"], name: "index_items_on_name_and_type", unique: true
  end

  create_table "level_up_cards", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "card_id", null: false
    t.integer "level", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_id"], name: "index_level_up_cards_on_card_id", unique: true
    t.index ["level"], name: "index_level_up_cards_on_level", unique: true
  end

  create_table "recipes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "card1_id", null: false
    t.uuid "card2_id", null: false
    t.uuid "card3_id", null: false
    t.uuid "card4_id", null: false
    t.uuid "card5_id", null: false
    t.uuid "item_id", null: false
    t.integer "quantity", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "creator_id"
    t.index ["card1_id", "card2_id", "card3_id", "card4_id", "card5_id"], name: "index_recipes_on_cards", unique: true
    t.index ["card1_id"], name: "index_recipes_on_card1_id"
    t.index ["card2_id"], name: "index_recipes_on_card2_id"
    t.index ["card3_id"], name: "index_recipes_on_card3_id"
    t.index ["card4_id"], name: "index_recipes_on_card4_id"
    t.index ["card5_id"], name: "index_recipes_on_card5_id"
    t.index ["creator_id"], name: "index_recipes_on_creator_id"
  end

  create_table "roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "role_id", null: false
    t.boolean "special_invitee", default: false, null: false
    t.datetime "active_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
