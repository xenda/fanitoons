class Group < ActiveRecord::Base
  has_many :matches
  
end

# == Schema Information
#
# Table name: groups
#
#  id   :integer         not null, primary key
#  name :string(255)
#

