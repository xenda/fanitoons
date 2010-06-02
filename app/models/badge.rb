class Badge < ActiveRecord::Base
  
  validates_presence_of :name
  
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

