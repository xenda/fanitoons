class AddTimeStampsToPlayers < ActiveRecord::Migration
  def self.up
change_table :players do |t|
  t.datetime :created_at
    t.datetime :updated_at
end
  end

  def self.down
change_table :players do |t|
  t.remove :created_at
    t.remove :updated_at
end
  end
end
