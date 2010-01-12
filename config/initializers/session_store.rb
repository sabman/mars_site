# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mars_site_session',
  :secret      => 'b016571d57b181cd3ef9acb4024fadd9c0b5b37c4452c127c763416421539137147051e0516fd2bf1389784f0fb9874a1b922c3a2ba4978c19dea49368588f7d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
