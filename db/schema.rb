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

ActiveRecord::Schema.define(version: 20140602205038) do

  create_table "admins", force: true do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "email"
    t.integer  "age"
    t.date     "dob"
    t.binary   "gender"
    t.integer  "privacy"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["remember_token"], name: "index_admins_on_remember_token"

  create_table "answers", force: true do |t|
    t.text     "text"
    t.integer  "value"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", force: true do |t|
    t.float    "average"
    t.text     "difficulty"
    t.integer  "user_id"
    t.integer  "quiz_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grades", ["quiz_id"], name: "index_grades_on_quiz_id"
  add_index "grades", ["user_id"], name: "index_grades_on_user_id"

  create_table "questions", force: true do |t|
    t.text     "text"
    t.string   "difficulty"
    t.integer  "maxValue"
    t.integer  "quiz_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quizzes", force: true do |t|
    t.string   "name"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "email"
    t.integer  "age"
    t.date     "dob"
    t.binary   "gender"
    t.integer  "privacy"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "videos", force: true do |t|
    t.string   "name"
    t.string   "filename"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "viewings", force: true do |t|
    t.integer  "user_id"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "viewings", ["user_id", "video_id"], name: "index_viewings_on_user_id_and_video_id", unique: true
  add_index "viewings", ["user_id"], name: "index_viewings_on_user_id"
  add_index "viewings", ["video_id"], name: "index_viewings_on_video_id"

  create_table "worksheets", force: true do |t|
    t.string   "name"
    t.string   "filename"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
