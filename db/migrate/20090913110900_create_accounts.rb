class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :subdomain
      t.timestamps
    end
  end

  def self.down
    remove_table :accounts
  end
end
