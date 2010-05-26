class Prediction < ActiveRecord::Base
  belongs_to :match
  belongs_to :account, :class_name => "Account", :foreign_key => "user_id"
  belongs_to :winner, :class_name => "Team", :foreign_key => "winner_id"

  def teams
    [match.local,match.visitor]
  end
  
  def local_winner?
    match.local == winner
  end
  
  def visitor_winner?
    match.visitor == winner
  end
    
end

# == Schema Information
#
# Table name: predictions
#
#  id                 :integer         not null, primary key
#  user_id            :integer
#  predicted_at       :datetime
#  match_id           :integer
#  winner_id          :integer
#  first_team_result  :integer
#  second_team_result :integer
#  scoring_player_id  :integer
#  victory_type_id    :integer
#  created_at         :datetime
#  updated_at         :datetime
#

