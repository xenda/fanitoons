class Match < ActiveRecord::Base
  belongs_to :stadium
  belongs_to :local, :class_name => "Team", :foreign_key => "first_team_id"
  belongs_to :visitor, :class_name => "Team", :foreign_key => "second_team_id"
  belongs_to :group
  
  has_many :prediction
  
end

