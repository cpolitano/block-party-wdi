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

ActiveRecord::Schema.define(version: 20141030183542) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blocks", force: true do |t|
    t.string  "screen_name"
    t.string  "name"
    t.string  "created_at"
    t.string  "twitter_id"
    t.integer "user_id"
  end

  add_index "blocks", ["user_id"], name: "index_blocks_on_user_id", using: :btree

  create_table "tweets", force: true do |t|
    t.string  "screenname"
    t.string  "name"
    t.string  "text"
    t.string  "date"
    t.string  "link_url"
    t.string  "created_at"
    t.string  "location"
    t.string  "tweetid"
    t.integer "user_id"
  end

  add_index "tweets", ["user_id"], name: "index_tweets_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "twitter_screen_name"
    t.string   "twitter_display_name"
  end

  create_table "words", force: true do |t|
    t.string  "word"
    t.integer "user_id"
  end

  add_index "words", ["user_id"], name: "index_words_on_user_id", using: :btree

end
