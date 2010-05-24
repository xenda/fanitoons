class CreatePosts < ActiveRecord::Migration
  def self.up
create_table :posts do |t|
  t.string :title
      t.text :content
end
  end

  def self.down
    drop_table :posts
  end
end
