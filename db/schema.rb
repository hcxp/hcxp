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

ActiveRecord::Schema.define(version: 20180302222835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "band_events", force: :cascade do |t|
    t.bigint "band_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_band_events_on_band_id"
    t.index ["event_id"], name: "index_band_events_on_event_id"
  end

  create_table "bands", force: :cascade do |t|
    t.string "uid"
    t.string "name"
    t.string "location"
    t.string "photo_uid"
    t.datetime "scrapped_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["uid"], name: "index_bands_on_uid"
  end

  create_table "events", force: :cascade do |t|
    t.string "facebook_event_id"
    t.string "name"
    t.string "city"
    t.string "country_code"
    t.datetime "start_at"
    t.string "poster_uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "state"
    t.string "place_name"
    t.string "nominatim_place_id"
    t.float "latitude"
    t.float "longitude"
    t.datetime "synced_at"
    t.index ["facebook_event_id"], name: "index_events_on_facebook_event_id"
    t.index ["nominatim_place_id"], name: "index_events_on_nominatim_place_id"
  end

  create_table "user_oauth_resources", force: :cascade do |t|
    t.bigint "user_id"
    t.string "uid"
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["uid"], name: "index_user_oauth_resources_on_uid"
    t.index ["user_id"], name: "index_user_oauth_resources_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "avatar_uid"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "band_events", "bands"
  add_foreign_key "band_events", "events"
  add_foreign_key "user_oauth_resources", "users"
end
