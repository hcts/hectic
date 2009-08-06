# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hectic_session',
  :secret      => '3c22d39392f8fe7cd3254c2883a590c412a2223bf1023b14d2d710fd5149cefd2f0cb7c6c9515a2feba56c1acb23bad4b090202d63dd73567fe35284945185f9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
