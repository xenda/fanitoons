class CreatePredictions < ActiveRecord::Migration
  def self.up
create_table :predictions do |t|
  t.integer :user_id
      t.datetime :predicted_at
      t.integer :match_id
      t.integer :winner_id
      t.integer :first_team_result
      t.integer :second_team_result
      t.integer :scoring_player_id
      t.integer :victory_type_id
      t.timestamps
end
  end

  def self.down
    drop_table :predictions
  end
end
