# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 7) do

  create_table "addresses", :force => true do |t|
    t.integer  "user_id",                           :null => false
    t.integer  "addresstype_id",                    :null => false
    t.integer  "country_id",                        :null => false
    t.text     "location",                          :null => false
    t.integer  "state_id"
    t.integer  "city_id"
    t.integer  "zipcode"
    t.text     "pobox"
    t.text     "phone"
    t.text     "fax"
    t.text     "movil"
    t.text     "other"
    t.boolean  "is_postaddress", :default => false, :null => false
    t.integer  "moduser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["user_id", "addresstype_id"], :name => "addresses_user_id_key", :unique => true

  create_table "addresstypes", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresstypes", ["name"], :name => "addresstypes_name_key", :unique => true

  create_table "careers", :force => true do |t|
    t.text     "name",           :null => false
    t.integer  "degree_id",      :null => false
    t.integer  "institution_id", :null => false
    t.integer  "moduser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "careers", ["name", "degree_id", "institution_id"], :name => "careers_name_key", :unique => true

  create_table "cities", :force => true do |t|
    t.integer  "state_id",   :null => false
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["state_id", "name"], :name => "cities_state_id_key", :unique => true

  create_table "countries", :force => true do |t|
    t.text   "name",                 :null => false
    t.text   "citizen",              :null => false
    t.string "code",    :limit => 3, :null => false
  end

  add_index "countries", ["name"], :name => "altered_countries_name_key", :unique => true
  add_index "countries", ["code"], :name => "altered_countries_code_key", :unique => true

  create_table "degrees", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "degrees", ["name"], :name => "degrees_name_key", :unique => true

  create_table "documents", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["name"], :name => "documents_name_key", :unique => true

  create_table "institutions", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "country_id", :null => false
    t.integer  "state_id"
    t.integer  "parent_id"
    t.integer  "moduser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.integer  "user_id",            :null => false
    t.integer  "country_id",         :null => false
    t.integer  "state_id",           :null => false
    t.integer  "city_id",            :null => false
    t.text     "firstname",          :null => false
    t.text     "lastname1",          :null => false
    t.text     "lastname2"
    t.text     "photo_filename"
    t.text     "photo_content_type"
    t.text     "other"
    t.boolean  "gender",             :null => false
    t.date     "birthdate",          :null => false
    t.binary   "photo"
    t.integer  "moduser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "periods", :force => true do |t|
    t.string   "name",                          :null => false
    t.date     "startdate",                     :null => false
    t.date     "enddate",                       :null => false
    t.boolean  "is_active",  :default => false, :null => false
    t.integer  "moduser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "periods", ["name", "startdate", "enddate"], :name => "periods_name_key", :unique => true

  create_table "roles", :force => true do |t|
    t.string   "name",               :null => false
    t.string   "administrative_key", :null => false
    t.integer  "moduser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], :name => "academicprograms_name_key", :unique => true

  create_table "schoolings", :force => true do |t|
    t.integer  "user_id",                               :null => false
    t.integer  "career_id",                             :null => false
    t.integer  "startmonth",                            :null => false
    t.integer  "startyear",                             :null => false
    t.integer  "endmonth"
    t.integer  "endyear"
    t.integer  "credits"
    t.integer  "estimated_endmonth"
    t.integer  "estimated_endyear"
    t.string   "studentid"
    t.float    "average"
    t.boolean  "is_studying_this",   :default => true,  :null => false
    t.boolean  "is_titleholder",     :default => false, :null => false
    t.binary   "file",                                  :null => false
    t.text     "filename",                              :null => false
    t.text     "content_type",                          :null => false
    t.integer  "moduser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", :force => true do |t|
    t.integer  "country_id", :null => false
    t.text     "name",       :null => false
    t.text     "code"
    t.integer  "moduser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "states", ["name", "country_id"], :name => "states_name_key", :unique => true

  create_table "trees", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "pos"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "root_id"
    t.string   "data"
    t.integer  "moduser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_documents", :force => true do |t|
    t.integer  "user_id",      :null => false
    t.integer  "document_id",  :null => false
    t.binary   "file",         :null => false
    t.text     "filename",     :null => false
    t.text     "content_type", :null => false
    t.integer  "moduser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_requests", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "period_id",  :null => false
    t.integer  "moduser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_requests", ["user_id", "period_id"], :name => "user_requests_user_id_key", :unique => true

  create_table "users", :force => true do |t|
    t.text     "login",                           :null => false
    t.text     "passwd"
    t.text     "salt"
    t.text     "email"
    t.text     "homepage"
    t.text     "blog"
    t.text     "calendar"
    t.text     "pkcs7"
    t.text     "token"
    t.integer  "userstatus_id",    :default => 1, :null => false
    t.datetime "token_expiry"
    t.integer  "user_incharge_id"
    t.integer  "moduser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "users_email_key", :unique => true
  add_index "users", ["login"], :name => "users_login_idx"
  add_index "users", ["id"], :name => "users_id_idx"

  create_table "userstatuses", :force => true do |t|
    t.text     "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "userstatuses", ["name"], :name => "userstatuses_name_key", :unique => true

end
