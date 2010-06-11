class Player < ActiveRecord::Base
  belongs_to :team
  belongs_to :country
  
  has_attached_file :picture, :styles => { :medium => "300x300", :thumb => "50x50>" },:path => ":rails_root/public/system/players/:attachment/:id/:style.:extension"
  
end


# == Schema Information
#
# Table name: players
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  born_at              :datetime
#  country              :string(255)
#  team_id              :integer
#  created_at           :datetime
#  updated_at           :datetime
#  bio                  :text
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

