class AddChampionshipIdToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :championship_id, :integer
  end

  def self.down
    remove_column :matches, :championship_id
  end
end
