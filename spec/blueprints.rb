require 'machinist/active_record'
require 'sham'
require 'faker'
require 'crypt/blowfish'

#blowfish  = Crypt::Blowfish.new(File.read("#{RAILS_ROOT}/config/key"))
#pass      = blowfish.decrypt_block("\302\233\247S\eN\247\"")

ldap_root   = YAML.load_file("#{RAILS_ROOT}/config/ldap_root_user.yml")
user        = ldap_root["username"]
pass        = ldap_root["password"]

User.blueprint do
  username {"sabman"}
  password {"secret"}
end

User.blueprint(:me) do
  username { user }
  password { pass }
end
