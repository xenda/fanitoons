class Badge < ActiveRecord::Base
  
  validates_presence_of :name
  has_attached_file :picture, :styles => { :medium => "300x300", :thumb => "50x50>" }
  
end


# == Schema Information
#
# Table name: badges
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  type        :string(255)
#

