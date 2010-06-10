class Country < ActiveRecord::Base
  has_many :stadia
  
  has_attached_file :picture, :styles => { :medium => "300x300", :thumb => "50x50>" }
  
end

# == Schema Information
#
# Table name: countries
#
#  id   :integer         not null, primary key
#  name :string(255)
#

