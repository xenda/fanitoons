class CreateFavoriteTeams < ActiveRecord::Migration
  def self.up
    create_table :favorite_teams do |t|
      t.integer :team_id
      t.integer :account_id

      t.timestamps
    end
  end

  def self.down
    drop_table :favorite_teams
  end
end
