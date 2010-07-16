class ChampionshipTeam < ActiveRecord::Base
  
  belongs_to :championship
  belongs_to :team
  
end

# == Schema Information
#
# Table name: championship_teams
#
#  id              :integer(4)      not null, primary key
#  team_id         :integer(4)
#  championship_id :integer(4)
#  created_at      :datetime
#  updated_at      :datetime
#

