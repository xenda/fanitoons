class Match < ActiveRecord::Base
  belongs_to :stadium
  belongs_to :local, :class_name => "Team", :foreign_key => "first_team_id"
  belongs_to :visitor, :class_name => "Team", :foreign_key => "second_team_id"
  belongs_to :group
  
  has_many :predictions
  
  def to_param
    "#{id}-#{local.name.parameterize}-vs-#{visitor.name.parameterize}"
  end
  
  
end


# == Schema Information
#
# Table name: matches
#
#  id                :integer         not null, primary key
#  number            :integer
#  played_at         :datetime
#  place             :string(255)
#  stadium_id        :integer
#  first_team_id     :integer
#  second_team_id    :integer
#  first_team_goals  :integer
#  second_team_goals :integer
#  created_at        :datetime
#  updated_at        :datetime
#  group_id          :integer
#

