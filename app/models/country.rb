class Country < ActiveRecord::Base
  has_many :stadia
  
  has_attached_file :picture, :styles => { :medium => "300x300", :thumb => "50x50>" },:path => ":rails_root/public/system/countries/:attachment/:id/:style.:extension", :url => "/system/countries/:attachment/:id/:style.:extension"
  
end




# == Schema Information
#
# Table name: countries
#
#  id                   :integer(4)      not null, primary key
#  name                 :string(255)
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer(4)
#  picture_updated_at   :datetime
#  iso_name             :string(255)
#

