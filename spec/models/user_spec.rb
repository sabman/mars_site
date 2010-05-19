require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  it "should find an ldap samaccountname for a given email" do
    User.find_ldap_username_by_email("shoaib.burq@ga.gov.au").should == "u63250"
  end

  it "should return a valid ldap_user_entry" do
    user.ldap_user_entry.should_not be nil
  end

  it "should return a valid email address" do
    user.email.should == "Shoaib.Burq@ga.gov.au"
  end

  it "should authenticate against GA ldap" do
    p = YAML.load_file(File.join(RAILS_ROOT, "config", "ldap_root_user.yml"))["password"]
    user.authenticate_against_ga_ldap(p).should == true
  end

  it "should find user by email and be able to authenticate the user" do
    user = User.new(:username => User.find_ldap_username_by_email("shoaib.burq@ga.gov.au"))
    user.authenticate_against_ga_ldap(
      YAML.load_file(File.join(RAILS_ROOT, "config", "ldap_root_user.yml"))["password"]
    ).should == true
  end

  private
  def user
    User.new(:username => "u63250")
  end
end
