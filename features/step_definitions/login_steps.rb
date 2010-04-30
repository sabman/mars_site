blowfish  = Crypt::Blowfish.new(File.read("#{RAILS_ROOT}/config/key"))
pass      = blowfish.decrypt_block("\302\233\247S\eN\247\"")

Given /^I am a GA user$/ do
  me = User.make(:me)
  me.authenticate_against_ga_ldap(me.password).should == true
end

Given /^I am logged in$/ do
  Given "I am a GA user"
  And   "I am on login page"
  When  "I fill in \"username\" with \"u63250\""
  And   "I fill in \"password\" with \"#{pass}\""
  And   "I press \"Login\""
  Then  "I should see \"Successfully logged in.\""
  And   "I should see \"Logout\""
end


When  "I fill in my username and password" do
  When  "I fill in \"username\" with \"u63250\""
  And   "I fill in \"password\" with \"#{pass}\""
end

Given "I am logged out" do
  require "authlogic/test_case"
  include Authlogic::TestCase
  activate_authlogic
  UserSession.find.try(:destroy)
end
