ldap_root   = YAML.load_file("#{RAILS_ROOT}/config/ldap_root_user.yml")
user        = ldap_root["username"]
pass        = ldap_root["password"]
LDAP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/ldap.yml")
LDAP_CONNECTION = Net::LDAP.new
LDAP_CONNECTION.host = LDAP_CONFIG["host"]
LDAP_CONNECTION.port = LDAP_CONFIG["port"]
LDAP_CONNECTION.base = LDAP_CONFIG["base"]
LDAP_CONNECTION.auth "#{user}@#{LDAP_CONFIG["full_base_dn"]}", pass
unless LDAP_CONNECTION.bind 
  msg = LDAP_CONNECTION.get_operation_result.message
  code = LDAP_CONNECTION.get_operation_result.code
  raise "LDAP Connection failed: Message #{msg}, Code: #{code}"
end
