class Group < ActiveRecord::Base
  has_many :matches
  
end


# == Schema Information
#
# Table name: groups
#
#  id   :integer(4)      not null, primary key
#  name :string(255)
#

