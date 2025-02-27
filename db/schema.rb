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

ActiveRecord::Schema.define(version: 2021_10_18_235358) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendships", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "friend_id"
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "showings", force: :cascade do |t|
    t.string "movie_title"
    t.integer "duration"
    t.string "day"
    t.string "start_time"
    t.integer "movie_id"
  end

  create_table "user_showings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "showing_id"
    t.boolean "user_hosting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["showing_id"], name: "index_user_showings_on_showing_id"
    t.index ["user_id"], name: "index_user_showings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "friendships", "users"
  add_foreign_key "user_showings", "showings"
  add_foreign_key "user_showings", "users"
end
