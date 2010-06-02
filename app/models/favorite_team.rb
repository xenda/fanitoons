class FavoriteTeam < ActiveRecord::Base
  
  belongs_to :team
  belongs_to :account
  
end

# == Schema Information
#
# Table name: favorite_teams
#
#  id         :integer         not null, primary key
#  team_id    :integer
#  account_id :integer
#  created_at :datetime
#  updated_at :datetime
#

