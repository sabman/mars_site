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

ActiveRecord::Schema.define(:version => 20091217062835) do

  create_table "surveys", :force => true do |t|
    t.column "eno", :integer
    t.column "surveyid", :string
    t.column "surveyname", :text
    t.column "surveytype", :string
    t.column "datatypes", :string
    t.column "uno", :string
    t.column "operator", :string
    t.column "contractor", :string
    t.column "processor", :string
    t.column "client", :string
    t.column "owner", :string
    t.column "legislation", :string
    t.column "countryid", :string
    t.column "state", :string
    t.column "proj_leader", :string
    t.column "on_off", :string
    t.column "startdate", :date
    t.column "enddate", :date
    t.column "vessel_type", :string
    t.column "spacemin", :integer
    t.column "spacemax", :integer
    t.column "locmethod", :string
    t.column "accuracy", :integer
    t.column "geodetic_datum", :string
    t.column "projection", :string
    t.column "access_code", :string
    t.column "qa_code", :string
    t.column "releasedate", :date
    t.column "comments", :text
    t.column "entrydate", :date
    t.column "enteredby", :string
    t.column "lastupdate", :date
    t.column "updatedby", :string
    t.column "data_activity_code", :string
    t.column "nlat", :decimal
    t.column "slat", :decimal
    t.column "elong", :decimal
    t.column "wlong", :decimal
    t.column "ano", :integer
    t.column "qaby", :string
    t.column "qadate", :date
    t.column "confid_until", :date
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "users", :force => true do |t|
    t.column "username", :string
    t.column "email", :string
    t.column "crypted_password", :string, :null => false
    t.column "password_salt", :string, :null => false
    t.column "persistence_token", :string, :null => false
    t.column "single_access_token", :string, :null => false
    t.column "perishable_token", :string, :null => false
    t.column "login_count", :integer, :default => 0, :null => false
    t.column "failed_login_count", :integer, :default => 0, :null => false
    t.column "last_request_at", :datetime
    t.column "current_login_at", :datetime
    t.column "last_login_at", :datetime
    t.column "current_login_ip", :string
    t.column "last_login_ip", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

end
