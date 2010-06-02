class AddPredictionsCountToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :predictions_count, :integer, :default => 0
  end

  def self.down
    remove_column :matches, :predictions_count
  end
end
