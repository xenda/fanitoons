class AddShortNameToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :short_name, :string
  end

  def self.down
    remove_column :teams, :short_name
  end
end
