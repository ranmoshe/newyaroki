# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_newyaroki_session',
  :secret      => 'f11168fb5f6772be6d78356d6da4f0f31f864c277c16fc174fd3be0a979397a637ea9ee8ffec25302103e2948a3ce5bf507d00675b8a61489869ba19b36a5640'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store