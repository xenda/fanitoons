class CreateComments < ActiveRecord::Migration
  def self.up
create_table :comments do |t|
  t.integer :post_id
      t.string :title
      t.text :content
      t.string :email
      t.string :user_id
      t.string :website
      t.timestamps
end
  end

  def self.down
    drop_table :comments
  end
end
