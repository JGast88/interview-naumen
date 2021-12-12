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

ActiveRecord::Schema.define(version: 2021_11_14_104121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_periods", force: :cascade do |t|
    t.string "name"
    t.datetime "start_at"
    t.datetime "end_at", default: "9999-01-01 00:00:00"
    t.bigint "department_id", null: false
    t.integer "parent_id"
    t.index ["department_id"], name: "index_active_periods_on_department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "disbanded_at"
  end

  create_table "people", force: :cascade do |t|
    t.string "fullname", null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type"
    t.string "{:null=>false}"
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "working_periods", force: :cascade do |t|
    t.datetime "start_at", null: false
    t.datetime "end_at", default: "9999-01-01 00:00:00"
    t.bigint "department_id"
    t.bigint "person_id"
    t.index ["department_id"], name: "index_working_periods_on_department_id"
    t.index ["person_id"], name: "index_working_periods_on_person_id"
  end

  add_foreign_key "active_periods", "departments"
  add_foreign_key "working_periods", "departments"
  add_foreign_key "working_periods", "people"
end
