class Prediction < ActiveRecord::Base
  belongs_to :match
  belongs_to :account, :class_name => "Account", :foreign_key => "user_id"
  belongs_to :winner, :class_name => "Team", :foreign_key => "winner_id"

  def teams
    [match.local,match.visitor]
  end
  
end
