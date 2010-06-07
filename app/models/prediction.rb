class Prediction < ActiveRecord::Base
  belongs_to :match, :counter_cache => true
  belongs_to :account, :class_name => "Account", :foreign_key => "user_id"
  belongs_to :winner, :class_name => "Team", :foreign_key => "winner_id"
  has_many :comments, :as => :commentable


  named_scope :last, lambda{|last| {:limit => last, :order =>"predicted_at DESC"}}

  attr_accessor :to_facebook
  
  def teams
    [match.local,match.visitor]
  end
  
  def local_winner?
    match.local == winner
  end
  
  def visitor_winner?
    match.visitor == winner
  end
    
  def prediction_text
    "#{first_team_result} a #{second_team_result}"
  end  
  
  def closeness
    first_team_abs = (first_team_result - match.first_team_goals).abs
    second_team_abs = (second_team_result - match.second_team_goals).abs
    
    first_team_abs + second_team_abs
  end
  
  def prediction_title
    case closeness
      when 0
        "¡acertada!"
      when 1
        "¡cerca!"
      when 1..2
        "cerca.. cerca.."
      else
        "¡para nada!"
      end
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

