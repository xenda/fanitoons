class DeviseCreateAdmins < ActiveRecord::Migration
  def self.up
    create_table(:admins) do |t|
      t.database_authenticatable :null => false
      t.trackable
      t.lockable

      t.timestamps
    end

    # add_index :admins, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :admins
  end
end
