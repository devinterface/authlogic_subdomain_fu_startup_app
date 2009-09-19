class User < ActiveRecord::Base
  
  belongs_to :account
  
  acts_as_authentic do |c|
    c.validations_scope = :account_id
  end

end
