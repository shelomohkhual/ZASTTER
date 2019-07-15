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

ActiveRecord::Schema.define(version: 2019_07_15_082227) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "followers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "follower_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "tweet_id"
  end

  create_table "replies", force: :cascade do |t|
    t.integer "tweet_id"
    t.integer "reply_id"
  end

  create_table "retweet", force: :cascade do |t|
    t.integer "tweet_id"
    t.integer "retweet_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "tweet_count"
  end

  create_table "tweet_tags", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "tweet_id"
  end

  create_table "tweets", force: :cascade do |t|
    t.integer "user_id"
    t.string "text", limit: 140, null: false
    t.integer "liked_count"
    t.integer "reply_count"
    t.integer "retweet_count"
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname"
    t.string "name"
    t.string "email"
    t.string "password_hash"
    t.integer "tweet_count"
    t.integer "following_count"
    t.integer "follower_count"
    t.integer "like_count"
  end

end
