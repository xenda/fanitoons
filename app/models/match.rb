class Match < ActiveRecord::Base
  belongs_to :stadium
  belongs_to :local, :class_name => "Team", :foreign_key => "first_team_id"
  belongs_to :visitor, :class_name => "Team", :foreign_key => "second_team_id"
  belongs_to :group
  has_many :comments, :as => :commentable
  has_many :predictions
  
  has_attached_file :picture, :styles => { :front=>"190x110#", :medium => "300x300#", :thumb => "50x50#" },:path => ":rails_root/public/system/matches/:attachment/:id/:style.:extension", :url => "/system/matches/:attachment/:id/:style.:extension"
  
  named_scope :most_popular, lambda{|limit| {:order=>"predictions_count DESC", :limit => limit } }
  
  validates_presence_of :first_team_id
  validates_presence_of :second_team_id
  
  def to_param
    if local and visitor
    "#{id}-#{local.name.parameterize}-vs-#{visitor.name.parameterize}"
    else
      "#{id}"
    end
  end
  
  
  def give_points 
    
    
    #runs from every prediction made
    self.predictions.each do |prediction|
      
      #for each one, see if the prediction was right:
      if prediction.just_right?
        
        badge = Badge.find_by_name("Pronóstico Correcto")
        user_badge = UserBadge.new
        user_badge.badge = badge
        user_badge.account = prediction.account
        user_badge.points = 2
        
        #if it choose the winner right, see if they get extra points for goals
        if prediction.totally_right?
          user_badge.points += 1
        end
        
        user_badge.save
        
      end

      
    end
    

  rescue

  raise "You need to create a Badge called 'Pronóstico Correcto'"    # Score 1pto
    # Partido 2ptos
    
    
    # Puntos por goles
    # Puntos por aciertos
    
    # Puntos por Empate
    
  end
  
  def winner
    return local if first_team_goals > second_team_goals
    return visitor if second_team_goals > first_team_goals
  end
  
  def tie?
    first_team_goals == second_team_goals
  end
  
  def name
    "Partido #{title}"
  end
  
  def local_winner?
    return false if first_team_goals.nil? or second_team_goals.nil?
    first_team_goals > second_team_goals
  end
  
  def visitor_winner?
    return false if first_team_goals.nil? or second_team_goals.nil?
    second_team_goals > first_team_goals
  end
  
  def tie?
    return false if first_team_goals.nil? or second_team_goals.nil?
    first_team_goals = second_team_goals
  end
  
  def title
    "#{local.name} - #{visitor.name}" if local && visitor
  end
  
  def local_winner_count
    @local_winner_count ||= predictions.count(:conditions=>{:winner_id=>local.id}) if local
  end
  
  def visitor_winner_count
    @visitor_winner_count ||= predictions.count(:conditions=>{:winner_id=>visitor.id}) if visitor
  end
  
  def average_tie
    local_winner_count == visitor_winner_count
  end
  
  def average_local_winner?
    return 0 unless local and visitor
    local_winner_count > visitor_winner_count 
  end
  
  def average_visitor_winner?
    return 0 unless local and visitor
    visitor_winner_count > local_winner_count
  end
    
  def average_result
    return 0 if average_result 
    return -1 if average_local_winner?
    return 1 if average_visitor_winner?
  end
  
  def self.matches_till_now
    Match.find(:all, :conditions=>["played_at < ?",Time.zone.now])
  end

  def self.matches_count_till_now
    Match.count(:all, :conditions=>["played_at < ?",Time.zone.now])
  end

  
end



# == Schema Information
#
# Table name: matches
#
#  id                   :integer         not null, primary key
#  number               :integer
#  played_at            :datetime
#  place                :string(255)
#  stadium_id           :integer
#  first_team_id        :integer
#  second_team_id       :integer
#  first_team_goals     :integer
#  second_team_goals    :integer
#  created_at           :datetime
#  updated_at           :datetime
#  group_id             :integer
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  predictions_count    :integer
#

