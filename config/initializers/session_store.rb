# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_patatoon_session',
  :secret      => '95192f1bf7cd7c4c2966b7a1cdc21443435605ee9a8e4b67bd8ddd9383ee5488be50e5218fbd5512a3753c6561d6d0bc85426c878414c24634f5a33a2e3755a2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
