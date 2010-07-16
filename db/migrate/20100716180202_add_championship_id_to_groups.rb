class AddChampionshipIdToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :championship_id, :integer
  end

  def self.down
    remove_column :groups, :championship_id
  end
end
