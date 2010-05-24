class AddCountryIdToTeams < ActiveRecord::Migration
  def self.up
change_table :teams do |t|
  t.integer :country_id
end
  end

  def self.down
change_table :teams do |t|
  t.remove :country_id
end
  end
end
