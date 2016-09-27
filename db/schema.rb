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

ActiveRecord::Schema.define(version: 20160927141255) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "puzzle_id"
    t.string   "answer"
    t.string   "answer_orginal"
    t.boolean  "success"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "bonus"
  end

  add_index "answers", ["puzzle_id"], name: "index_answers_on_puzzle_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "puzzle_id"
    t.integer  "user_id"
    t.string   "subject"
    t.text     "message"
    t.boolean  "publish"
    t.boolean  "isCommentTop"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "comments", ["puzzle_id"], name: "index_comments_on_puzzle_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "puzzles", force: :cascade do |t|
    t.integer  "no"
    t.string   "name"
    t.text     "question"
    t.text     "answer"
    t.datetime "publish_date"
    t.boolean  "isTabled"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "year"
    t.boolean  "publish"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "score"
  end

  create_table "tabled_user_scores", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tabled_user_scores", ["user_id"], name: "index_tabled_user_scores_on_user_id", using: :btree

  create_table "user_scores", force: :cascade do |t|
    t.integer  "score"
    t.integer  "year"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.integer  "tabled_score"
  end

  add_index "user_scores", ["user_id"], name: "index_user_scores_on_user_id", using: :btree

# Could not dump table "users" because of following StandardError
#   Unknown type 'gender' for column 'gender'

  create_table "votes", force: :cascade do |t|
    t.integer  "puzzle_id"
    t.integer  "user_id"
    t.integer  "popularity"
    t.integer  "difficulty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "votes", ["puzzle_id"], name: "index_votes_on_puzzle_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  add_foreign_key "answers", "puzzles"
  add_foreign_key "answers", "users"
  add_foreign_key "comments", "puzzles"
  add_foreign_key "comments", "users"
  add_foreign_key "tabled_user_scores", "users"
  add_foreign_key "votes", "puzzles"
  add_foreign_key "votes", "users"
end
