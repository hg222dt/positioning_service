# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150225204542) do

  create_table "doodles", force: :cascade do |t|
    t.string   "doodle_text"
    t.integer  "tag_id"
    t.integer  "location_id"
    t.integer  "end_user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "end_users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "username"
    t.string   "bio_text"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "locations", force: :cascade do |t|
    t.float    "lat"
    t.float    "lng"
    t.float    "distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",             null: false
    t.string   "password_digest",   null: false
    t.string   "webbsite_url"
    t.string   "website_name"
    t.string   "authkey"
    t.boolean  "is_user_admin"
    t.boolean  "admin_revoked_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
