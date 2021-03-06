class Prediction < ActiveRecord::Base
  belongs_to :match, :counter_cache => true
  belongs_to :account, :class_name => "Account", :foreign_key => "user_id"
  belongs_to :winner, :class_name => "Team", :foreign_key => "winner_id"
  belongs_to :scoring_player, :class_name => "Player", :foreign_key => "scoring_player_id"
  has_many :comments, :as => :commentable


  named_scope :last, lambda{|last| {:limit => last, :order =>"created_at DESC"}}
  named_scope :most_commented, lambda{|limit| {:limit=> limit, :select =>"`predictions`.*, (select count(*) from comments where comments.commentable_id = `predictions`.id and comments.commentable_type like 'Prediction') as comments_count", :order => "comments_count DESC" }  }
  
  validates_presence_of :match_id
  
  
  record_activity_of :account, :actions => [:create, :update]
      
  attr_accessor :to_facebook
  
  def to_param
    "#{id}-#{name.parameterize}"
  end
  
  def name
    "#{match.local.name} (#{first_team_result}) vs #{match.visitor.name} (#{second_team_result})"
  end
  
  def undoable?
    #if less than 5 hours to the match
   Time.zone.now + 5.hours > self.match.played_at
   
  end
  
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
  
  # Score complete
  def totally_right?
    closeness == 0
  end
  
  # Just predicted winner
  def just_right?
    self.winner == match.winner
  end
  
  def closeness
    return false unless first_team_result
    return false unless second_team_result
    return 1000 if match.first_team_goals.nil? or match.second_team_goals.nil?
    first_team_abs = (first_team_result - match.first_team_goals).abs
    second_team_abs = (second_team_result - match.second_team_goals).abs
    
    first_team_abs + second_team_abs
  end
  
  def prediction_title
    case closeness
      when 0
        "<span class='right'>¡acertada!</span>"
      when 1
        "<span class='close'>¡cerca!</span>"
      when 1..2
        "<span class='almost'>cerca.. cerca..</span>"
      when 1000
        ""
      else
        "<span class='wrong'>¡para nada!</span>"
      end
  end
  
end


# == Schema Information
#
# Table name: predictions
#
#  id                 :integer(4)      not null, primary key
#  user_id            :integer(4)
#  predicted_at       :datetime
#  match_id           :integer(4)
#  winner_id          :integer(4)
#  first_team_result  :integer(4)
#  second_team_result :integer(4)
#  scoring_player_id  :integer(4)
#  victory_type_id    :integer(4)
#  created_at         :datetime
#  updated_at         :datetime
#

