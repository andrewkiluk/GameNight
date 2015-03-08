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

ActiveRecord::Schema.define(version: 20150302012400) do

  create_table "events", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "host_id"
  end

  add_index "events", ["host_id"], name: "index_events_on_host_id"

  create_table "game_event_votes", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "event_id"
    t.integer  "game_event_id"
    t.integer  "user_id"
  end

  add_index "game_event_votes", ["event_id"], name: "index_game_event_votes_on_event_id"
  add_index "game_event_votes", ["game_event_id"], name: "index_game_event_votes_on_game_event_id"
  add_index "game_event_votes", ["user_id"], name: "index_game_event_votes_on_user_id"

  create_table "game_events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "game_id"
    t.integer  "event_id"
  end

  add_index "game_events", ["event_id"], name: "index_game_events_on_event_id"
  add_index "game_events", ["game_id"], name: "index_game_events_on_game_id"

  create_table "games", force: :cascade do |t|
    t.text     "title"
    t.datetime "last_sync"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "bgg_gameId"
    t.integer  "bgg_minPlayers"
    t.integer  "bgg_maxPlayers"
    t.float    "bgg_bggRating"
    t.string   "bgg_image"
    t.string   "bgg_thumbnail"
    t.integer  "bgg_playingTime"
    t.integer  "bgg_rank"
  end

  create_table "invitations", force: :cascade do |t|
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "event_id"
    t.integer  "user_id"
  end

  add_index "invitations", ["event_id"], name: "index_invitations_on_event_id"
  add_index "invitations", ["user_id"], name: "index_invitations_on_user_id"

  create_table "libraries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "library_games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "library_id"
    t.integer  "game_id"
  end

  add_index "library_games", ["game_id"], name: "index_library_games_on_game_id"
  add_index "library_games", ["library_id"], name: "index_library_games_on_library_id"

  create_table "relations", force: :cascade do |t|
    t.integer  "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.integer  "related_user_id"
    t.integer  "inverse_id"
  end

  add_index "relations", ["inverse_id"], name: "index_relations_on_inverse_id"
  add_index "relations", ["related_user_id"], name: "index_relations_on_related_user_id"
  add_index "relations", ["user_id"], name: "index_relations_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.binary   "hashed_password"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "library_id"
  end

  add_index "users", ["library_id"], name: "index_users_on_library_id"

end
