class UpdateDateForGroups < ActiveRecord::Migration
  def self.up
    
    Group.all.each do |g|
      g.championship = Championship.first
      g.save
    end
    
  end

  def self.down
  end
end
