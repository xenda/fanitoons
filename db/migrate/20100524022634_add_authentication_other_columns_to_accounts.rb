class AddAuthenticationOtherColumnsToAccounts < ActiveRecord::Migration
  def self.up
    change_column :accounts, :email, :string,:default => "", :null => false
    add_column :accounts, :encrypted_password, :string, :limit => 128, :default => "", :null => false
    add_column :accounts, :password_salt, :string, :default => "", :null => false
    add_column :accounts, :confirmation_token,:string
    add_column :accounts, :confirmed_at, :datetime
    add_column :accounts, :confirmation_sent_at, :datetime 
    add_column :accounts, :reset_password_token, :string  
    add_column :accounts, :remember_token, :string  
    add_column :accounts, :remember_created_at, :datetime 
    add_column :accounts, :sign_in_count, :integer, :default => 0
    add_column :accounts, :current_sign_in_at, :datetime 
    add_column :accounts, :last_sign_in_at, :datetime 
    add_column :accounts, :current_sign_in_ip, :string   
    add_column :accounts, :last_sign_in_ip, :string   
    
  
  end

  def self.down
    change_column :accounts, :column_name, :string
    remove_column :accounts, :column_name
  end
end
