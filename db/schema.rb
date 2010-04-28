# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100428070127) do

# Could not dump table "comments" because of following NoMethodError
#   undefined method `spatial' for #<ActiveRecord::ConnectionAdapters::OracleEnhancedIndexDefinition:0x2aa046bae8>

# Could not dump table "regions" because of following NoMethodError
#   undefined method `spatial' for #<ActiveRecord::ConnectionAdapters::OracleEnhancedIndexDefinition:0x2aa046b7f0>

# Could not dump table "sessions" because of following NoMethodError
#   undefined method `spatial' for #<ActiveRecord::ConnectionAdapters::OracleEnhancedIndexDefinition:0x2aa046b390>

  create_table "surveys", :force => true do |t|
    t.integer  "eno",                :precision => 38, :scale => 0
    t.string   "surveyid"
    t.text     "surveyname"
    t.string   "surveytype"
    t.string   "datatypes"
    t.string   "uno"
    t.string   "operator"
    t.string   "contractor"
    t.string   "processor"
    t.string   "client"
    t.string   "owner"
    t.string   "legislation"
    t.string   "countryid"
    t.string   "state"
    t.string   "proj_leader"
    t.string   "on_off"
    t.datetime "startdate"
    t.datetime "enddate"
    t.string   "vessel_type"
    t.integer  "spacemin",           :precision => 38, :scale => 0
    t.integer  "spacemax",           :precision => 38, :scale => 0
    t.string   "locmethod"
    t.integer  "accuracy",           :precision => 38, :scale => 0
    t.string   "geodetic_datum"
    t.string   "projection"
    t.string   "access_code"
    t.string   "qa_code"
    t.datetime "releasedate"
    t.text     "comments"
    t.datetime "entrydate"
    t.string   "enteredby"
    t.datetime "lastupdate"
    t.string   "updatedby"
    t.string   "data_activity_code"
    t.integer  "nlat",               :precision => 38, :scale => 0
    t.integer  "slat",               :precision => 38, :scale => 0
    t.integer  "elong",              :precision => 38, :scale => 0
    t.integer  "wlong",              :precision => 38, :scale => 0
    t.integer  "ano",                :precision => 38, :scale => 0
    t.string   "qaby"
    t.datetime "qadate"
    t.datetime "confid_until"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "role",                                               :default => "viewer", :null => false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                                                        :null => false
    t.string   "single_access_token",                                                      :null => false
    t.string   "perishable_token",                                                         :null => false
    t.integer  "login_count",         :precision => 38, :scale => 0, :default => 0,        :null => false
    t.integer  "failed_login_count",  :precision => 38, :scale => 0, :default => 0,        :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
