class CreateTitles < ActiveRecord::Migration
  def self.up
    create_table :titles do |t|
      t.integer :score_needed
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :titles
  end
end
