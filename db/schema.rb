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

ActiveRecord::Schema.define(version: 2020_04_23_015759) do

  create_table "groups", force: :cascade do |t|
    t.integer "user_id"
    t.integer "guest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", nil], name: "index_groups_on_user_id_and_guest_id", unique: true
    t.index ["user_id"], name: "index_groups_on_user_id"
    t.index [nil], name: "index_groups_on_guest_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_name"
  end

  create_table "parties", force: :cascade do |t|
    t.string "team_name"
    t.string "image_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "host_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.integer "user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "user_id"
    t.integer "guest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "team_name"
    t.string "image_name"
  end

end
