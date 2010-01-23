# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_chordbrowser_session',
  :secret      => 'f2c2db6d6b352b722b218278b8f132d4f73695856fcab6751ca1faaa9adb37d745b7caf9ab058c9f72229e2038bd4a4bfa7f54fac42b42379b16c9390457fd62'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
