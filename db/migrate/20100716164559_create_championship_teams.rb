class CreateChampionshipTeams < ActiveRecord::Migration
  def self.up
    create_table :championship_teams do |t|
      t.integer :team_id
      t.integer :championship_id

      t.timestamps
    end
  end

  def self.down
    drop_table :championship_teams
  end
end
