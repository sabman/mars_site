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

ActiveRecord::Schema.define(:version => 20100201055721) do

  create_table "regions", :force => true do |t|
    t.column "name", :string
    t.column "geometry", :text
    t.column "coordinates", :string
    t.column "corners", :string
    t.column "minlon", :decimal
    t.column "maxlon", :decimal
    t.column "minlat", :decimal
    t.column "maxlat", :decimal
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

# Could not dump table "sessions" because of following ArgumentError
#   wrong number of arguments (2 for 5) /d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/activerecord-2.3.5/lib/active_record/connection_adapters/sqlite_adapter.rb:235:in `initialize'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/activerecord-2.3.5/lib/active_record/connection_adapters/sqlite_adapter.rb:235:in `new'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/activerecord-2.3.5/lib/active_record/connection_adapters/sqlite_adapter.rb:235:in `indexes'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/activerecord-2.3.5/lib/active_record/connection_adapters/sqlite_adapter.rb:234:in `map'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/activerecord-2.3.5/lib/active_record/connection_adapters/sqlite_adapter.rb:234:in `indexes'/d/mac/1/sburq/root/opt/lib/spatial_adapter/lib/common_spatial_adapter.rb:80:in `indexes'/d/mac/1/sburq/root/opt/lib/spatial_adapter/lib/common_spatial_adapter.rb:66:in `table'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/activerecord-oracle_enhanced-adapter-1.2.3/lib/active_record/connection_adapters/oracle_enhanced_schema_dumper.rb:29:in `tables'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/activerecord-oracle_enhanced-adapter-1.2.3/lib/active_record/connection_adapters/oracle_enhanced_schema_dumper.rb:17:in `each'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/activerecord-oracle_enhanced-adapter-1.2.3/lib/active_record/connection_adapters/oracle_enhanced_schema_dumper.rb:17:in `tables'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/activerecord-2.3.5/lib/active_record/schema_dumper.rb:25:in `dump'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/activerecord-2.3.5/lib/active_record/schema_dumper.rb:19:in `dump'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rails-2.3.5/lib/tasks/databases.rake:260/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rails-2.3.5/lib/tasks/databases.rake:259:in `open'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rails-2.3.5/lib/tasks/databases.rake:259/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:636:in `call'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:636:in `execute'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:631:in `each'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:631:in `execute'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:597:in `invoke_with_call_chain'/d/mac/1/sburq/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/1.8/monitor.rb:242:in `synchronize'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:590:in `invoke_with_call_chain'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:583:in `invoke'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rails-2.3.5/lib/tasks/databases.rake:117/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:636:in `call'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:636:in `execute'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:631:in `each'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:631:in `execute'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:597:in `invoke_with_call_chain'/d/mac/1/sburq/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/1.8/monitor.rb:242:in `synchronize'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:590:in `invoke_with_call_chain'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:583:in `invoke'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:2051:in `invoke_task'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:2029:in `top_level'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:2029:in `each'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:2029:in `top_level'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:2068:in `standard_exception_handling'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:2023:in `top_level'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:2001:in `run'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:2068:in `standard_exception_handling'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/lib/rake.rb:1998:in `run'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/gems/rake-0.8.7/bin/rake:31/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/bin/rake:19:in `load'/d/mac/1/sburq/.rvm/gems/ruby-1.8.7-p249/bin/rake:19

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
    t.column "role", :string, :default => "viewer", :null => false
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
