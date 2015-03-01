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

ActiveRecord::Schema.define(version: 20150301234140) do

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

end
