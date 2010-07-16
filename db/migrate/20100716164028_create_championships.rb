class CreateChampionships < ActiveRecord::Migration
  def self.up
    create_table :championships do |t|
      t.string :name
      t.datetime :started_at
      t.datetime :finished_at
      t.text :description
      t.string :place
      t.integer :winner_id

      t.timestamps
    end
  end

  def self.down
    drop_table :championships
  end
end
