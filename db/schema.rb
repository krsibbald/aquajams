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

ActiveRecord::Schema.define(version: 20160509011449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cds", force: :cascade do |t|
    t.string   "name"
    t.integer  "code"
    t.integer  "time_in_sec"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "mixes", force: :cascade do |t|
    t.string   "name"
    t.integer  "length_in_sec"
    t.date     "recorded_at"
    t.text     "description"
    t.text     "source"
    t.text     "music_type"
    t.text     "notes"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "code"
    t.boolean  "multiple",          default: false, null: false
    t.date     "date_for_mix_list"
  end

  create_table "songs", force: :cascade do |t|
    t.string   "name"
    t.integer  "artist_id"
    t.integer  "length_in_sec"
    t.integer  "year"
    t.integer  "top_billboard_spot"
    t.decimal  "billboard_weeks"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "cd_id"
    t.integer  "bpm"
  end

  add_index "songs", ["artist_id"], name: "index_songs_on_artist_id", using: :btree
  add_index "songs", ["cd_id"], name: "index_songs_on_cd_id", using: :btree
  add_index "songs", ["name", "cd_id", "artist_id"], name: "index_songs_on_name_and_cd_id_and_artist_id", unique: true, using: :btree

  create_table "tracks", force: :cascade do |t|
    t.integer  "mix_id"
    t.integer  "song_id"
    t.integer  "ord"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tracks", ["mix_id"], name: "index_tracks_on_mix_id", using: :btree
  add_index "tracks", ["song_id"], name: "index_tracks_on_song_id", using: :btree

  add_foreign_key "songs", "artists"
  add_foreign_key "tracks", "mixes"
  add_foreign_key "tracks", "songs"
end
