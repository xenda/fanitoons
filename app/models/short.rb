class Short < ActiveRecord::Base

  has_attached_file :picture, :styles => { :medium => "300x300", :thumb => "50x50>" }

end

# == Schema Information
#
# Table name: shorts
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

