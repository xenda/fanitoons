class AddAuthenticationColumnsToAccounts < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
     t.database_authenticatable
     t.confirmable
     t.recoverable
     t.rememberable
     t.trackable
     t.timestamps
   end
  end

  def self.down
    remove_column :accounts, :column_name
    remove_column :accounts, :database
  end
end
