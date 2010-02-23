# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mars_site_session',
  :secret      => '27d9f4710876bbfb1719389bf1c4f35056a3c08bf8a4adb50435e68b93e6518d53b5e643caa4d69fc66394adc24b2068ea801804bc1d28520725513bdb4c8c54'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
