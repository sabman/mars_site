# Use sendmail 
ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.sendmail_settings = { 
  :location       => '/usr/sbin/sendmail.sendmail', 
  :arguments      => '-t'
} 

# Gmail settings as per http://mail.google.com/support/bin/answer.py?answer=78799
#Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
#ActionMailer::Base.delivery_method = :smtp
#ActionMailer::Base.perform_deliveries = true
#ActionMailer::Base.raise_delivery_errors = true
#ActionMailer::Base.default_charset = "utf-8"
#ActionMailer::Base.smtp_settings = {
#  :tls => true, # http://en.wikipedia.org/wiki/Transport_Layer_Security
#  #:enable_starttls_auto => true, # for ruby 1.8.7 >
#  :address => "smtp.gmail.com",
#  :port => "587",
#  #:port => "465",
#  :domain => "mail.google.com",
#  #:authentication => :login,
#  :authentication => :plain, 
#  :user_name => "marine.samples@gmail.com",
#  :password => "abc123753951"
#}
#ActionMailer::Base.smtp_settings = { 
#  :address => "smtp.gmail.com", 
#  :port => 587,
#  :authentication => :plain, 
#  :enable_starttls_auto => true, 
#  :user_name => "kwiqi@kwiqi.com",
#  :password => "superB1rd!" 
#}
