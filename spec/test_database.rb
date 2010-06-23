require 'rubygems'
require 'active_record'
# test ORAPROD
a = ActiveRecord::Base.establish_connection(YAML.load_file("../lib/config/database.yml")["production"])
begin
  puts "== Testing ORAPROD =="
  a.connection
  puts "all good!"
rescue Exception => e
  puts e.message
end

# test ORADEV
a = ActiveRecord::Base.establish_connection(YAML.load_file("../config/database.yml")["development"])
begin
  puts "== Testing ORADEV =="
  a.connection
  puts "all good!"
rescue Exception => e
  puts e.message
end

# test ORATEST
a = ActiveRecord::Base.establish_connection(YAML.load_file("../config/database.yml")["test"])
begin
  puts "== Testing ORATEST =="
  a.connection
  puts "all good!"
rescue Exception => e
  puts e.message
end
