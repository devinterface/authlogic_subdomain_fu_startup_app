class AddOwnerReferenceToAccounts < ActiveRecord::Migration
  def self.up
    add_column :accounts, :owner_id, :integer
  end

  def self.down
    remove_column :accounts, :owner_id
  end
end
