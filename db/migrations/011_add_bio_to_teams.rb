class AddBioToTeams < ActiveRecord::Migration
  def self.up
change_table :teams do |t|
  t.text :bio
end
  end

  def self.down
change_table :teams do |t|
  t.remove :bio
end
  end
end
