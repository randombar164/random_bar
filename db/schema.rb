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

ActiveRecord::Schema.define(version: 2021_03_01_052135) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "base_drinks", force: :cascade do |t|
    t.string "name"
    t.float "strength"
    t.text "cook_explanation"
    t.bigint "drink_method_id"
    t.bigint "glass_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drink_method_id"], name: "index_base_drinks_on_drink_method_id"
    t.index ["glass_type_id"], name: "index_base_drinks_on_glass_type_id"
  end

  create_table "base_drinks_base_ingredients", force: :cascade do |t|
    t.bigint "base_ingredient_id"
    t.bigint "base_drink_id"
    t.string "amount"
    t.string "additional_explanation"
    t.bigint "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_drink_id"], name: "base_drinks_base_ingredients_d_index_name"
    t.index ["base_ingredient_id"], name: "base_drinks_base_ingredients_i_index_name"
    t.index ["unit_id"], name: "index_base_drinks_base_ingredients_on_unit_id"
  end

  create_table "base_ingredients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "concrete_ingredients", force: :cascade do |t|
    t.bigint "base_ingredient_id"
    t.string "name"
    t.text "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_ingredient_id"], name: "index_concrete_ingredients_on_base_ingredient_id"
  end

  create_table "concrete_ingredients_handling_stores", force: :cascade do |t|
    t.bigint "concrete_ingredient_id"
    t.bigint "handling_store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["concrete_ingredient_id"], name: "concrete_ingredients_handling_stores_c_index_name"
    t.index ["handling_store_id"], name: "concrete_ingredients_handling_stores_h_index_name"
  end

  create_table "drink_methods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "uuid"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events_base_ingredients", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "base_ingredient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_ingredient_id"], name: "event_base_ingredient_index_name_2"
    t.index ["event_id"], name: "event_base_ingredient_index_name_1"
  end

  create_table "glass_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "handling_stores", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "substitutions", force: :cascade do |t|
    t.integer "substituted_id"
    t.integer "substituting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["substituted_id"], name: "index_substitutions_on_substituted_id"
    t.index ["substituting_id"], name: "index_substitutions_on_substituting_id"
  end

  create_table "unit_conversions", force: :cascade do |t|
    t.bigint "unit_id"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_unit_conversions_on_unit_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "base_drinks", "drink_methods"
  add_foreign_key "base_drinks", "glass_types"
  add_foreign_key "base_drinks_base_ingredients", "base_drinks"
  add_foreign_key "base_drinks_base_ingredients", "base_ingredients"
  add_foreign_key "base_drinks_base_ingredients", "units"
  add_foreign_key "concrete_ingredients", "base_ingredients"
  add_foreign_key "concrete_ingredients_handling_stores", "concrete_ingredients"
  add_foreign_key "concrete_ingredients_handling_stores", "handling_stores"
  add_foreign_key "events_base_ingredients", "base_ingredients"
  add_foreign_key "events_base_ingredients", "events"
  add_foreign_key "unit_conversions", "units"
end
