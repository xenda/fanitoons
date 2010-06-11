class AddRememberToAdmins < ActiveRecord::Migration
  def self.up
    add_column :admins, :remember_token, :string  
    add_column :admins, :remember_created_at, :datetime

  end

  def self.down
    remove_column :admins, :remember_created_at
    remove_column :admins, :column_name
  end
end
