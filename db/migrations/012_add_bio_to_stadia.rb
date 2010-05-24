class AddBioToStadia < ActiveRecord::Migration
  def self.up
change_table :stadia do |t|
  t.text :bio
end
  end

  def self.down
change_table :stadia do |t|
  t.remove :bio
end
  end
end
