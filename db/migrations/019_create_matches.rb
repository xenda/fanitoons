class CreateMatches < ActiveRecord::Migration
  def self.up
create_table :matches do |t|
  t.integer :number
      t.datetime :played_at
      t.string :place
      t.integer :stadium_id
      t.integer :first_team_id
      t.integer :second_team_id
      t.integer :first_team_goals
      t.integer :second_team_goals
      t.timestamps
end
  end

  def self.down
    drop_table :matches
  end
end
