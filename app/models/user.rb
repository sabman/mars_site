class User < ActiveRecord::Base
  has_many :regions

  attr_reader :ldap_user_entry
  acts_as_authentic do |c|
    c.validate_password_field = false
    c.validate_email_field = false
  end


  def owns?(object)
    object.user == self
  end

  def admin?
    self.role == "admin"
  end

  # return true or false depending on the success of the authentication
  def authenticate_against_ga_ldap(plain_text_password)
    ldap = LDAP_CONNECTION
    ldap.auth "#{self.username}@#{LDAP_CONFIG["full_base_dn"]}", "#{plain_text_password}"
    if ldap.bind
      return true
    else
      errors.add_to_base "Result: #{ldap.get_operation_result.code}"
      errors.add_to_base "Message: #{ldap.get_operation_result.message}"
      return false
    end
  end

  def ldap_user_exists?
  end

  # populate the ldap_entry instance variable
  def ldap_user_entry
    filter = Net::LDAP::Filter.eq("sAMAccountName", self.username)
    unless @ldap_user_entry 
      @ldap_user_entry ||= LDAP_CONNECTION.search(:filter => filter, :size => 1)[0] rescue false
    end
    @ldap_user_entry
  end

  def self.find_ldap_username_by_email(email)
    filter = Net::LDAP::Filter.eq("mail", email)
    LDAP_CONNECTION.search(:filter => filter, :size=>1)[0].samaccountname[0] rescue nil
  end

  def email
    ldap_user_entry.mail.first
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def first_name
    ldap_user_entry.givenname.first
  end

  def last_name
    ldap_user_entry.sn.first
  end

  def department
    ldap_user_entry.department.first
  end

  def office_phone
    ldap_user_entry.telephonenumber.first
  end

  def to_param
    if full_name
      "#{id}-#{full_name.to_s.parameterize.downcase}"
    else
      id.to_s
    end
  end

end
