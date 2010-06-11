class AddIsoNameToCountries < ActiveRecord::Migration
  def self.up
    add_column :countries, :iso_name, :string
  end

  def self.down
    remove_column :countries, :iso_name
  end
end
