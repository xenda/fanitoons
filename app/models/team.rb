class Team < ActiveRecord::Base
  has_many :matches
  belongs_to :country
  
  has_many :favorite_teams, :class_name => "FavoriteTeam", :foreign_key => "team_id"
  has_many :accounts, :through => :favorite_teams
  
end

# == Schema Information
#
# Table name: teams
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  country    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  bio        :text
#  country_id :integer
#

