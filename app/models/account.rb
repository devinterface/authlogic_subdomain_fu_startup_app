class Account < ActiveRecord::Base
  
  authenticates_many :user_sessions
  
  has_many :users, :uniq => true
  accepts_nested_attributes_for :users
  
  alias_attribute :user_id, :owner_id

  validates_presence_of :subdomain

  validates_format_of :subdomain, 
                      :with => /^[A-Za-z0-9-]+$/, 
                      :message => ' can only contain alphanumeric characters and dashes.', 
                      :allow_blank => true

  validates_exclusion_of :subdomain, 
                         :in => %w( support blog www billing help api mail ), 
                         :message => " <strong>{{value}}</strong> is reserved and unavailable."
  
  validates_uniqueness_of :subdomain, :case_sensitive => false

  before_validation :downcase_subdomain
  
  after_create :add_owner

  private

  def downcase_subdomain
    self.subdomain.downcase! if attribute_present?("subdomain")
  end
  
  def add_owner
    self.owner_id = self.users.first.id
    self.save
  end
end
