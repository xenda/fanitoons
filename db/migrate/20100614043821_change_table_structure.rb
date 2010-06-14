class ChangeTableStructure < ActiveRecord::Migration
  def self.up
    
    create_table :gang do |t|
      t.string   :name
      t.string   :description
      t.string   :image
      t.string   :state
      t.boolean  :private
      t.boolean  :moderated, :default => false
      t.integer  :user_id
      t.string   :activation_code, :limit => 40
      t.datetime :activated_at
      t.timestamps
    end

    create_table :memberships do |t|
      t.integer  :user_id
      t.integer  :group_id
      t.boolean  :moderator, :default => false
      t.string   :state
      t.string   :activation_code, :limit => 40
      t.datetime :activated_at
      t.timestamps
    end

    drop_table :friendships
    create_table :friendships do |t|
      t.integer  :inviter_id
      t.integer  :invited_id
      t.integer  :status
      t.timestamps
    end
    
    
  end

  def self.down
  end
end
