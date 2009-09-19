# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_new_app_name1_session',
  :secret      => '38bdea73417d4bd763d5692d87366e0503bc7e540c1cb64298d6d60f9fcf4ea80f6938060adccce050a6dc473cb66d1456563d1dbd5ca6f20531d808e61711d4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
