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

ActiveRecord::Schema.define(version: 20140617134710) do

  create_table "admins", force: true do |t|
    t.string   "displayName"
    t.string   "realName"
    t.string   "email"
    t.date     "dob"
    t.binary   "gender"
    t.text     "biography"
    t.integer  "privilege"
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

  create_table "certifications", force: true do |t|
    t.integer  "grade"
    t.integer  "wage"
    t.integer  "status",     default: 0
    t.integer  "subject_id"
    t.integer  "tutor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", force: true do |t|
    t.float    "average"
    t.text     "difficulty"
    t.integer  "student_id"
    t.integer  "quiz_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grades", ["quiz_id"], name: "index_grades_on_quiz_id"
  add_index "grades", ["student_id"], name: "index_grades_on_student_id"

  create_table "questions", force: true do |t|
    t.text     "text"
    t.integer  "maxValue"
    t.integer  "quiz_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quizzes", force: true do |t|
    t.string   "name"
    t.integer  "quizParent_id"
    t.string   "quizParent_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.datetime "time"
    t.string   "location"
    t.integer  "duration"
    t.integer  "price"
    t.text     "tutorNote"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions_students", id: false, force: true do |t|
    t.integer "session_id", null: false
    t.integer "student_id", null: false
  end

  add_index "sessions_students", ["session_id"], name: "index_sessions_students_on_session_id"
  add_index "sessions_students", ["student_id"], name: "index_sessions_students_on_student_id"

  create_table "sessions_subjects", id: false, force: true do |t|
    t.integer "session_id", null: false
    t.integer "subject_id", null: false
  end

  add_index "sessions_subjects", ["session_id"], name: "index_sessions_subjects_on_session_id"
  add_index "sessions_subjects", ["subject_id"], name: "index_sessions_subjects_on_subject_id"

  create_table "students", force: true do |t|
    t.string   "displayName"
    t.string   "realName"
    t.string   "email"
    t.string   "location"
    t.integer  "zipcode"
    t.integer  "phone"
    t.date     "dob"
    t.binary   "gender"
    t.text     "biography"
    t.integer  "privacy"
    t.integer  "status",          default: 2
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["email"], name: "index_students_on_email", unique: true
  add_index "students", ["remember_token"], name: "index_students_on_remember_token"

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tutors", force: true do |t|
    t.string   "displayName"
    t.string   "realName"
    t.string   "email"
    t.string   "location"
    t.integer  "zipcode"
    t.integer  "phone"
    t.date     "dob"
    t.binary   "gender"
    t.text     "biography"
    t.string   "fileName"
    t.integer  "privacy"
    t.integer  "status",          default: 0
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tutors", ["email"], name: "index_tutors_on_email", unique: true
  add_index "tutors", ["remember_token"], name: "index_tutors_on_remember_token"

  create_table "videos", force: true do |t|
    t.string   "name"
    t.string   "filename"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "viewings", force: true do |t|
    t.integer  "student_id"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "viewings", ["student_id", "video_id"], name: "index_viewings_on_student_id_and_video_id", unique: true
  add_index "viewings", ["student_id"], name: "index_viewings_on_student_id"
  add_index "viewings", ["video_id"], name: "index_viewings_on_video_id"

  create_table "worksheets", force: true do |t|
    t.string   "name"
    t.string   "filename"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
