class Badge < ActiveRecord::Base
  
  validates_presence_of :name
  has_attached_file :picture, :styles => { :medium => "300x300", :thumb => "50x50>" },:path => ":rails_root/public/system/badges/:attachment/:id/:style.:extension", :url => "/system/badges/:attachment/:id/:style.:extension"
  
  
end




# == Schema Information
#
# Table name: badges
#
#  id                   :integer(4)      not null, primary key
#  name                 :string(255)
#  description          :text
#  created_at           :datetime
#  updated_at           :datetime
#  type                 :string(255)
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer(4)
#  picture_updated_at   :datetime
#

