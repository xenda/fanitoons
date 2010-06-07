class Match < ActiveRecord::Base
  belongs_to :stadium
  belongs_to :local, :class_name => "Team", :foreign_key => "first_team_id"
  belongs_to :visitor, :class_name => "Team", :foreign_key => "second_team_id"
  belongs_to :group
  has_many :comments, :as => :commentable
  has_many :predictions
  
  has_attached_file :picture, :styles => { :front=>"190x110#", :medium => "300x300#", :thumb => "50x50#" }
  
  named_scope :most_popular, lambda{|limit| {:order=>"predictions_count DESC", :limit => limit } }
  
  def to_param
    "#{id}-#{local.name.parameterize}-vs-#{visitor.name.parameterize}"
  end
  
  def title
    "#{local.name} - #{visitor.name}" if local && visitor
  end
  
  def local_winner_count
    @local_winner_count ||= predictions.count(:conditions=>{:winner_id=>local.id})
  end
  
  def visitor_winner_count
    @visitor_winner_count ||= predictions.count(:conditions=>{:winner_id=>visitor.id})
  end
  
  def average_tie
    local_winner_count == visitor_winner_count
  end
  
  def average_local_winner?
    local_winner_count > visitor_winner_count
  end
  
  def average_visitor_winner?
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

