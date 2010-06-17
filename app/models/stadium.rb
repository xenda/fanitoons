class Stadium < ActiveRecord::Base
  has_many :matches
  belongs_to :country
  
  has_attached_file :picture, :styles => { :medium => "300x300", :thumb => "50x50>" },:path => ":rails_root/public/system/stadia/:attachment/:id/:style.:extension", :url => "/system/stadia/:attachment/:id/:style.:extension"
  
end



# == Schema Information
#
# Table name: stadia
#
#  id                   :integer(4)      not null, primary key
#  name                 :string(255)
#  city                 :string(255)
#  country              :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  bio                  :text
#  country_id           :integer(4)
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer(4)
#  picture_updated_at   :datetime
#

