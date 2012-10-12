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

ActiveRecord::Schema.define(:version => 20120906211037) do

  create_table "candidates", :force => true do |t|
    t.integer  "status_id"
    t.string   "archive_reason"
    t.integer  "technology_id"
    t.integer  "expertise_level_id"
    t.string   "name"
    t.integer  "contact_source_id"
    t.string   "refered_by"
    t.string   "gender"
    t.string   "marital_status"
    t.string   "property"
    t.datetime "birth_date"
    t.string   "university"
    t.string   "degree"
    t.integer  "graduation_year"
    t.text     "certifications"
    t.text     "address"
    t.string   "email"
    t.string   "telephone"
    t.string   "mobile"
    t.string   "office_telephone"
    t.string   "citizenship"
    t.string   "has_visa"
    t.integer  "visa_expiration_year"
    t.string   "has_passport"
    t.integer  "passport_expiration_year"
    t.string   "is_willing_to_travel"
    t.string   "is_willing_to_relocate"
    t.string   "availability_to_start"
    t.string   "currently_employed"
    t.string   "company"
    t.string   "time_there"
    t.string   "position"
    t.string   "relationship"
    t.string   "contract_type"
    t.string   "salary_expectancy"
    t.string   "current_salary"
    t.text     "comments"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "first_last_name"
    t.string   "second_last_name"
    t.string   "address1"
    t.string   "neighborhood"
    t.integer  "zip_code",                 :limit => 8
    t.string   "city"
    t.string   "country"
    t.integer  "home_phone",               :limit => 8
    t.integer  "cell_phone",               :limit => 8
    t.integer  "office_phone",             :limit => 8
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "password_confirmation"
    t.string   "change_password_flag"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "resume_id"
    t.string   "updated_by"
  end

  add_index "candidates", ["email"], :name => "index_candidates_on_email", :unique => true

  create_table "certifications", :force => true do |t|
    t.string  "name"
    t.string  "description"
    t.boolean "approved_flag", :default => false
    t.integer "approved_by"
  end

  create_table "education_degrees", :force => true do |t|
    t.string  "name"
    t.string  "description"
    t.boolean "approved_flag", :default => false
    t.integer "approved_by"
  end

  create_table "educations", :force => true do |t|
    t.integer  "resume_id"
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "degree_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experience_details", :force => true do |t|
    t.integer  "experience_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experiences", :force => true do |t|
    t.integer  "resume_id"
    t.string   "company_name"
    t.string   "job_position"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followings", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "followings", ["followed_id"], :name => "index_followings_on_followed_id"
  add_index "followings", ["follower_id"], :name => "index_followings_on_follower_id"

  create_table "idiom_levels", :force => true do |t|
    t.string  "name"
    t.string  "description"
    t.boolean "approved_flag", :default => false
    t.integer "approved_by"
  end

  create_table "idioms", :force => true do |t|
    t.string   "name"
    t.string   "level"
    t.integer  "resume_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "knowledge_tags", :force => true do |t|
    t.integer "profile_id"
    t.integer "role_id"
    t.string  "name"
    t.string  "description"
    t.boolean "approved_flag", :default => false
    t.string  "approved_by"
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "candidate_id"
  end

  create_table "profiles", :force => true do |t|
    t.string  "name"
    t.string  "description"
    t.boolean "approved_flag", :default => false
    t.integer "approved_by"
  end

  create_table "project_knowledge_tags", :force => true do |t|
    t.integer  "project_role_id"
    t.string   "name"
    t.string   "description"
    t.datetime "date_in"
    t.datetime "date_out"
  end

  create_table "project_responsibility_tags", :force => true do |t|
    t.integer "project_role_id"
    t.string  "description"
  end

  create_table "project_roles", :force => true do |t|
    t.integer  "project_id"
    t.integer  "role_id"
    t.datetime "date_in"
    t.datetime "date_out"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_technology_tags", :force => true do |t|
    t.integer  "project_role_id"
    t.string   "name"
    t.string   "version"
    t.string   "description"
    t.datetime "date_in"
    t.datetime "date_out"
  end

  create_table "project_tool_tags", :force => true do |t|
    t.integer  "project_role_id"
    t.string   "name"
    t.string   "version"
    t.string   "description"
    t.datetime "date_in"
    t.datetime "date_out"
  end

  create_table "projects", :force => true do |t|
    t.integer "resume_id"
    t.string  "name"
    t.string  "summary"
    t.string  "company_name"
  end

  create_table "resume_certifications", :force => true do |t|
    t.integer  "resume_id"
    t.integer  "certification_id"
    t.datetime "date_out"
  end

  create_table "resume_details", :force => true do |t|
    t.string   "summary"
    t.integer  "resume_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_educations", :force => true do |t|
    t.integer  "resume_id"
    t.integer  "education_degree_id"
    t.string   "title"
    t.string   "school_name"
    t.datetime "date_in"
    t.datetime "date_out"
  end

  create_table "resume_idioms", :force => true do |t|
    t.integer "resume_id"
    t.integer "idiom_level_id"
    t.string  "name"
  end

  create_table "resume_summaries", :force => true do |t|
    t.integer  "resume_id"
    t.string   "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_trainings", :force => true do |t|
    t.integer  "resume_id"
    t.string   "name"
    t.string   "description"
    t.datetime "date_out"
  end

  create_table "resumes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "candidate_id"
  end

  create_table "roles", :force => true do |t|
    t.string  "name"
    t.string  "description"
    t.boolean "approved_flag", :default => false
    t.integer "approved_by"
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.string   "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "technology_tags", :force => true do |t|
    t.integer "profile_id"
    t.integer "role_id"
    t.string  "name"
    t.string  "version"
    t.string  "description"
    t.boolean "approved_flag", :default => false
    t.string  "approved_by"
  end

  create_table "tool_tags", :force => true do |t|
    t.integer "profile_id"
    t.integer "role_id"
    t.string  "name"
    t.string  "version"
    t.string  "description"
    t.boolean "approved_flag", :default => false
    t.string  "approved_by"
  end

  create_table "tools", :force => true do |t|
    t.integer  "skill_id"
    t.integer  "experience_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",                             :default => false
    t.string   "change_password_flag"
    t.string   "gender"
    t.datetime "birthday"
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
