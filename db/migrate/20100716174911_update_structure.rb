class UpdateStructure < ActiveRecord::Migration
  def self.up
    
    world_cup = Championship.create :name => "Mundial 2010"
    world_cup.teams = Team.all
    world_cup.save
    Match.all.each do |m|
      m.championship = world_cup
      m.save
    end
    
  end

  def self.down
  end
end
