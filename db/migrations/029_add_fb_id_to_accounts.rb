class AddFbIdToAccounts < ActiveRecord::Migration
  def self.up
change_table :accounts do |t|
  t.integer :fb_id
end
  end

  def self.down
change_table :accounts do |t|
  t.remove :fb_id
end
  end
end
