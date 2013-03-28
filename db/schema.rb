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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120601194407) do

  create_table "educations", :force => true do |t|
    t.integer  "resume_id"
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "degree_level"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "experience_details", :force => true do |t|
    t.integer  "experience_id"
    t.string   "content"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "experiences", :force => true do |t|
    t.integer  "resume_id"
    t.string   "company_name"
    t.string   "job_position"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "description"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "followings", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "followings", ["followed_id"], :name => "index_followings_on_followed_id"
  add_index "followings", ["follower_id"], :name => "index_followings_on_follower_id"

  create_table "idioms", :force => true do |t|
    t.string   "name"
    t.string   "level"
    t.integer  "resume_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["user_id"], :name => "index_microposts_on_user_id"

  create_table "resume_details", :force => true do |t|
    t.string   "summary"
    t.integer  "resume_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "resume_summaries", :force => true do |t|
    t.integer  "resume_id"
    t.string   "summary"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "resumes", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.string   "version"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tools", :force => true do |t|
    t.integer  "skill_id"
    t.integer  "experience_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",                             :default => false
    t.string   "change_password_flag"
    t.string   "gender"
    t.date     "birthday"
    t.string   "address"
    t.string   "city"
    t.integer  "zip_code",             :limit => 8
    t.string   "country"
    t.integer  "home_phone",           :limit => 8
    t.integer  "office_phone",         :limit => 8
    t.integer  "cell_phone",           :limit => 8
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "last_name"
    t.string   "second_last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
