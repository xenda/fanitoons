class AddTypeToBadges < ActiveRecord::Migration
  def self.up
    add_column :badges, :type, :string
  end

  def self.down
    remove_column :badges, :type
  end
end
