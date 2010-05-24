class AddTimeStampsToTeams < ActiveRecord::Migration
  def self.up
change_table :teams do |t|
  t.datetime :created_at
    t.datetime :updated_at
end
  end

  def self.down
change_table :teams do |t|
  t.remove :created_at
    t.remove :updated_at
end
  end
end
