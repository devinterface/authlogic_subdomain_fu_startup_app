Factory.define :user do |u|
  u.last_login_at 'Thu Sep 17 14:20:58 +0200 2009'
  u.last_request_at 'Thu Sep 17 14:20:58 +0200 2009'
  u.updated_at 'Thu Sep 17 14:20:58 +0200 2009'
  u.account_id 1
  u.crypted_password 'foo'
  u.current_login_ip 'foo'
  u.current_login_at 'Thu Sep 17 14:20:58 +0200 2009'
  u.password_salt 'foo'
  u.login_count 1
  u.persistence_token 'foo'
  u.login 'foo'
  u.last_login_ip 'foo'
  u.email 'foo'
  u.created_at 'Thu Sep 17 14:20:58 +0200 2009'
end
