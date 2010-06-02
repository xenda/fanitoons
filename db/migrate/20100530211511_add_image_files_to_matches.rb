class AddImageFilesToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :picture_file_name, :string
    add_column :matches, :picture_content_type, :string
    add_column :matches, :picture_file_size, :integer
    add_column :matches, :picture_updated_at, :datetime
  end

  def self.down
    remove_column :matches, :picture_updated_at
    remove_column :matches, :picture_file_size
    remove_column :matches, :picture_content_type
    remove_column :matches, :picture_file_name
  end
end
