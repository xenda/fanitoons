class AddThumbnailsToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :thumbnail_file_name, :string
    add_column :accounts, :thumbnail_content_type, :string
    add_column :accounts, :thumbnail_file_size, :integer
    add_column :accounts, :thumbnail_updated_at, :datetime
  end

  def self.down
  end
end
