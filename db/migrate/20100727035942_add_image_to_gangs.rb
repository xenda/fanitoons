class AddImageToGangs < ActiveRecord::Migration
  def self.up
    add_column :gangs, :image_file_name, :string
    add_column :gangs, :image_content_type, :string
    add_column :gangs, :image_file_size, :integer
    add_column :gangs, :image_updated_at, :datetime
    remove_column :gangs, :image
    
  end

  def self.down
  end
end
