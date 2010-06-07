class CreateShares < ActiveRecord::Migration
  def self.up
    create_table :shares, :force => true do |t|
      t.column :user_id,            :integer
      t.column :shareable_type,     :string, :limit => 30
      t.column :shareable_id,       :integer
      t.column :shared_to_type,     :string, :limit => 30
      t.column :shared_to_id,        :integer
      t.column :created_at,         :datetime
      t.column :updated_at,         :datetime
    end
  end

  def self.down
    drop_table :shares
  end
end