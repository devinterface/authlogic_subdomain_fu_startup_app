ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => "111.111.111.111",
  :port => 25,
  :domain => "example.com",
  :authentication => :login,
  :user_name => "devinterface@example.com",
  :password => "password"  
}
