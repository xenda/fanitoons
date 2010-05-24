class AddGenderToAccounts < ActiveRecord::Migration
  def self.up
change_table :accounts do |t|
  t.string :gender
end
  end

  def self.down
change_table :accounts do |t|
  t.remove :gender
end
  end
end
