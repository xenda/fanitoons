class AddCountryIdToStadia < ActiveRecord::Migration
  def self.up
change_table :stadia do |t|
  t.integer :country_id
end
  end

  def self.down
change_table :matches do |t|
  t.remove :country_id
end
  end
end
