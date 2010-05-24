class AddAccountToPost < ActiveRecord::Migration
  def self.up
change_table :posts do |t|
  t.integer :account_id
end
  end

  def self.down
change_table :posts do |t|
  t.remove :account_id
end
  end
end
