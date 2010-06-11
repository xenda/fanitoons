class Short < ActiveRecord::Base

  has_attached_file :picture, :styles => { :medium => "300x300", :thumb => "50x50>" },:path => ":rails_root/public/system/shorts/:attachment/:id/:style.:extension", :url => "/system/shorts/:attachment/:id/:style.:extension"

end


# == Schema Information
#
# Table name: shorts
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

