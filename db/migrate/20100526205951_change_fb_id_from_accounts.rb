class ChangeFbIdFromAccounts < ActiveRecord::Migration
  def self.up
    change_column :accounts, :fb_id, :string
  end

  def self.down
    change_column :accounts, :fb_id, :string
  end
end
