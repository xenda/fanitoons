class Team < ActiveRecord::Base
  has_many :matches, :foreign_key => "first_team_id"
  has_many :matches2, :class_name => "Match", :foreign_key => "second_team_id"
  belongs_to :country
  has_many :comments, :as => :commentable
  
  has_many :favorite_teams, :class_name => "FavoriteTeam", :foreign_key => "team_id"
  has_many :accounts, :through => :favorite_teams
  
  has_attached_file :picture, :styles => { :medium => "300x300", :thumb => "50x50>" },:path => ":rails_root/public/system/teams/:attachment/:id/:style.:extension", :url => "/system/teams/:attachment/:id/:style.:extension"
  has_attached_file :flag, :styles => { :medium => "300x300", :thumb => "50x50>" },:path => ":rails_root/public/system/flags/:attachment/:id/:style.:extension", :url => "/system/flags/:attachment/:id/:style.:extension"
  
  before_save :create_short_name
  
  def create_short_name
    self.short_name = self.name.upcase[0..2] unless self.short_name
  end
  
  def flag_name
    return self.name[0..2] unless short_name
    self.short_name.downcase
  end
end




# == Schema Information
#
# Table name: teams
#
#  id                   :integer(4)      not null, primary key
#  name                 :string(255)
#  country              :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  bio                  :text
#  country_id           :integer(4)
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer(4)
#  picture_updated_at   :datetime
#  flag_file_name       :string(255)
#  flag_content_type    :string(255)
#  flag_file_size       :integer(4)
#  flag_updated_at      :datetime
#  short_name           :string(255)
#

