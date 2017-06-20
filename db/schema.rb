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

ActiveRecord::Schema.define(version: 20170620014320) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image"
    t.index ["user_id"], name: "index_accounts_on_user_id", using: :btree
  end

  create_table "budgets", force: :cascade do |t|
    t.integer  "trip_id"
    t.integer  "value"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_budgets_on_trip_id", using: :btree
  end

  create_table "days", force: :cascade do |t|
    t.integer  "theme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "comment"
    t.date     "date"
    t.index ["theme_id"], name: "index_days_on_theme_id", using: :btree
  end

  create_table "dinners", force: :cascade do |t|
    t.integer  "day_id"
    t.boolean  "todo"
    t.integer  "style"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_dinners_on_day_id", using: :btree
  end

  create_table "lunches", force: :cascade do |t|
    t.integer  "day_id"
    t.boolean  "todo"
    t.integer  "style"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_lunches_on_day_id", using: :btree
  end

  create_table "plannings", force: :cascade do |t|
    t.integer  "day_id"
    t.integer  "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_plannings_on_day_id", using: :btree
    t.index ["trip_id"], name: "index_plannings_on_trip_id", using: :btree
  end

  create_table "rythmes", force: :cascade do |t|
    t.integer  "trip_id"
    t.integer  "value"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "walking"
    t.integer  "transport"
    t.index ["trip_id"], name: "index_rythmes_on_trip_id", using: :btree
  end

  create_table "styles", force: :cascade do |t|
    t.integer  "trip_id"
    t.boolean  "culture"
    t.boolean  "nature"
    t.boolean  "sport"
    t.boolean  "food"
    t.boolean  "shopping"
    t.boolean  "kid"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_styles_on_trip_id", using: :btree
  end

  create_table "themes", force: :cascade do |t|
    t.string   "name"
    t.text     "descr"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trips", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "status"
    t.date     "date"
    t.text     "comment"
    t.integer  "adults"
    t.integer  "kids"
    t.index ["user_id"], name: "index_trips_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "provider"
    t.string   "uid"
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "budgets", "trips"
  add_foreign_key "days", "themes"
  add_foreign_key "dinners", "days"
  add_foreign_key "lunches", "days"
  add_foreign_key "plannings", "days"
  add_foreign_key "plannings", "trips"
  add_foreign_key "rythmes", "trips"
  add_foreign_key "styles", "trips"
  add_foreign_key "trips", "users"
end
