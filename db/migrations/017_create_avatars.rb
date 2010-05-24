class CreateAvatars < ActiveRecord::Migration
  def self.up
      create_table :avatars do |t|
        t.integer :user_id
        t.integer :shirt_id
        t.integer :short_id
        t.integer :snicker_id
        t.integer :shirt_rotation
        t.integer :short_rotation
        t.integer :snicker_rotation
        t.integer :shirt_scale
        t.integer :short_scale
        t.integer :snicker_scale
        t.timestamps      
      end
  end

  def self.down
    drop_table :avatars
  end
end
