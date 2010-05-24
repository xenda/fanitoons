class AddPictureToAccounts < ActiveRecord::Migration
  def self.up
    change_table :accounts do |t|
        t.string    :picture_file_name
        t.string    :picture_content_type
        t.integer   :picture_file_size
        t.datetime  :picture_updated_at
    end
  end

  def self.down
    change_table :accounts do |t|
        t.remove    :picture_file_name
        t.remove    :picture_content_type
        t.remove    :picture_file_size
        t.remove    :picture_updated_at
    end
  end
end
