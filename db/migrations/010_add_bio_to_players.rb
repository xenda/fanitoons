class AddBioToPlayers < ActiveRecord::Migration
  def self.up
change_table :players do |t|
  t.text :bio
end
  end

  def self.down
change_table :players do |t|
  t.remove :bio
end
  end
end
