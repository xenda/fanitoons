class RemoveCountryFromTeams < ActiveRecord::Migration
  def self.up
    # remove_column :teams, :country
  end

  def self.down
    # add_column :teams, :country, :string
  end
end
