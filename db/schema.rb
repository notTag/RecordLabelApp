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

ActiveRecord::Schema.define(version: 20161018234937) do

  create_table "rooms", force: :cascade do |t|
    t.string   "openHour",   limit: 255
    t.string   "closeHour",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "bandName",      limit: 255
    t.date     "sessionDate"
    t.time     "sessionTime"
    t.integer  "sessionLength", limit: 4
    t.text     "comments",      limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "studios", force: :cascade do |t|
    t.string   "studioName",  limit: 255
    t.time     "lunchHours"
    t.integer  "numberRooms", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "userType",      limit: 255
    t.string   "name",          limit: 255
    t.string   "contactNumber", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

end
