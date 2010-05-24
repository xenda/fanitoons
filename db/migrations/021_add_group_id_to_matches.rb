class AddGroupIdToMatches < ActiveRecord::Migration
  def self.up
change_table :matches do |t|
  t.integer :group_id
end
  end

  def self.down
change_table :matches do |t|
  t.remove :group_id
end
  end
end
