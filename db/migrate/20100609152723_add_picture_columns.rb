class AddPictureColumns < ActiveRecord::Migration
  def self.up
    add_column :badges, :picture_file_name, :string
    add_column :badges, :picture_content_type, :string
    add_column :badges, :picture_file_size, :integer
    add_column :badges, :picture_updated_at, :datetime
    
    add_column :countries, :picture_file_name, :string
    add_column :countries, :picture_content_type, :string
    add_column :countries, :picture_file_size, :integer
    add_column :countries, :picture_updated_at, :datetime
    
    add_column :players, :picture_file_name, :string
    add_column :players, :picture_content_type, :string
    add_column :players, :picture_file_size, :integer
    add_column :players, :picture_updated_at, :datetime
    
    add_column :posts, :picture_file_name, :string
    add_column :posts, :picture_content_type, :string
    add_column :posts, :picture_file_size, :integer
    add_column :posts, :picture_updated_at, :datetime
    
    add_column :shirts, :picture_file_name, :string
    add_column :shirts, :picture_content_type, :string
    add_column :shirts, :picture_file_size, :integer
    add_column :shirts, :picture_updated_at, :datetime
    
    add_column :shorts, :picture_file_name, :string
    add_column :shorts, :picture_content_type, :string
    add_column :shorts, :picture_file_size, :integer
    add_column :shorts, :picture_updated_at, :datetime
    
    add_column :snickers, :picture_file_name, :string
    add_column :snickers, :picture_content_type, :string
    add_column :snickers, :picture_file_size, :integer
    add_column :snickers, :picture_updated_at, :datetime
    
    add_column :stadia, :picture_file_name, :string
    add_column :stadia, :picture_content_type, :string
    add_column :stadia, :picture_file_size, :integer
    add_column :stadia, :picture_updated_at, :datetime
    
    add_column :teams, :picture_file_name, :string
    add_column :teams, :picture_content_type, :string
    add_column :teams, :picture_file_size, :integer
    add_column :teams, :picture_updated_at, :datetime
    
    add_column :teams, :flag_file_name, :string
    add_column :teams, :flag_content_type, :string
    add_column :teams, :flag_file_size, :integer
    add_column :teams, :flag_updated_at, :datetime
    
  end

  def self.down
  end
end
