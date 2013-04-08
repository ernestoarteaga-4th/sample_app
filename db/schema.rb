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

ActiveRecord::Schema.define(:version => 20130408162430) do

  create_table "candidate_certifications", :force => true do |t|
    t.integer  "certification_id"
    t.integer  "candidate_id"
    t.date     "year"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "candidate_contact_sources", :force => true do |t|
    t.integer  "candidate_id"
    t.string   "sources"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "candidate_languages", :force => true do |t|
    t.integer  "level_id"
    t.integer  "candidate_id"
    t.integer  "language_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "candidate_prof_summaries", :force => true do |t|
    t.string   "summary"
    t.integer  "candidate_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "candidates", :force => true do |t|
    t.integer  "status_id"
    t.integer  "techonlogy_id"
    t.string   "name"
    t.string   "gender"
    t.datetime "birthdate"
    t.string   "university"
    t.string   "degree"
    t.integer  "graduation_year"
    t.string   "certifcations"
    t.string   "address"
    t.string   "email"
    t.boolean  "has_visa"
    t.integer  "visa_expiration_year"
    t.boolean  "has_passport"
    t.integer  "passport_expiration_year"
    t.boolean  "is_willing_to_travel"
    t.boolean  "is_willing_to_relocate"
    t.boolean  "currently_employed"
    t.string   "company"
    t.string   "position"
    t.integer  "salary_expectancy"
    t.integer  "current_salary"
    t.string   "comments"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "first_last_name"
    t.string   "second_last_name"
    t.string   "address1"
    t.string   "neighborhood"
    t.string   "city"
    t.string   "country"
    t.integer  "zip_code"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.string   "office_phone"
    t.boolean  "change_password_flag"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at",               :null => false
    t.integer  "resume_id"
    t.datetime "updated_at",               :null => false
    t.integer  "updated_by"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "candidates_education", :force => true do |t|
    t.integer  "educ_degrees_id"
    t.integer  "candidate_id"
    t.string   "title"
    t.string   "degree"
    t.datetime "date_in"
    t.datetime "date_out"
    t.string   "university"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "candidates_interviews", :force => true do |t|
    t.integer  "candidate_id"
    t.string   "result"
    t.integer  "interviewer_id"
    t.integer  "interview_type_id"
    t.string   "comments"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "candidates_states", :force => true do |t|
    t.integer  "candidate_id"
    t.string   "description"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "certifications", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "approved_flag"
    t.string   "approved_by"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "educ_degrees", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "approved_flag"
    t.string   "approved_by"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "education_degrees", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "approved_flag"
    t.string   "approved_by"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
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

  create_table "expertise_levels", :force => true do |t|
    t.integer  "candidate_id"
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "filter_languages", :force => true do |t|
    t.integer  "candidate_language_id"
    t.integer  "language_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "followings", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "followings", ["followed_id"], :name => "index_followings_on_followed_id"
  add_index "followings", ["follower_id"], :name => "index_followings_on_follower_id"

  create_table "interviewers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "interviews_types", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "approved_flag"
    t.string   "approved_by"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["user_id"], :name => "index_microposts_on_user_id"

  create_table "projects", :force => true do |t|
    t.integer  "resume_id"
    t.string   "company_name"
    t.string   "job_position"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "description"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

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

  create_table "resume_trainings", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "year"
    t.integer  "resume_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "resumes", :force => true do |t|
    t.integer  "candidate_id"
    t.string   "updated_by"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
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
