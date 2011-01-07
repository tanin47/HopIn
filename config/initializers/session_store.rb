# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_HopIn_session',
  :secret      => '84a5b8de809b42a328d09a4f70d080ac06b707074f66793f6aa93800be6d4fe4ae6e5176cb94a86f8e53a7fa961c03d5bb7051d9569e97c4ec20f57c4d65d207'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
