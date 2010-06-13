class AddTitleToAccounts < ActiveRecord::Migration
  def self.up
    add_column :accounts, :title, :integer
  end

  def self.down
    remove_column :accounts, :title
  end
end
