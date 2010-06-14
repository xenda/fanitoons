class ChangeMigration < ActiveRecord::Migration
  def self.up
    rename_table :gang, :gangs
  end

  def self.down
    rename_table :gangs, :gang
  end
end
