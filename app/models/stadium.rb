class Stadium < ActiveRecord::Base
  has_many :matches
  belongs_to :country
  
  has_attached_file :picture, :styles => { :medium => "300x300", :thumb => "50x50>" }
  
end

# == Schema Information
#
# Table name: stadia
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  city       :string(255)
#  country    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  bio        :text
#  country_id :integer
#

