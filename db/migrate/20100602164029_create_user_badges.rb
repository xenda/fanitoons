class CreateUserBadges < ActiveRecord::Migration
  def self.up
    create_table :user_badges do |t|
      t.integer :user_id
      t.integer :badge_id
      t.datetime :earned_at
      t.integer :points

      t.timestamps
    end
  end

  def self.down
    drop_table :user_badges
  end
end
