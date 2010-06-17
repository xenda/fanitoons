class FavoriteTeam < ActiveRecord::Base
  
  belongs_to :team
  belongs_to :account
  
end


# == Schema Information
#
# Table name: favorite_teams
#
#  id         :integer(4)      not null, primary key
#  team_id    :integer(4)
#  account_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

