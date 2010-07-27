class ChangeGroupIdColumnToMemberships < ActiveRecord::Migration
  def self.up
    remove_column :memberships, :group_id 
    add_column :memberships, :gang_id, :integer
  end

  def self.down
    remove_column :memberships, :gang_id
    add_column :memberships, :group_id, :integer
  end
end
