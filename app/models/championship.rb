class Championship < ActiveRecord::Base
  
  has_many :championship_teams
  has_many :teams, :through => :championship_teams
  has_many :groups
  
  belongs_to :winner, :class_name => "Team", :foreign_key => "winner_id"
  
end

# == Schema Information
#
# Table name: championships
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  started_at  :datetime
#  finished_at :datetime
#  description :text
#  place       :string(255)
#  winner_id   :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

