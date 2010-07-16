class Group < ActiveRecord::Base
  has_many :matches
  belongs_to :championship
end



# == Schema Information
#
# Table name: groups
#
#  id              :integer(4)      not null, primary key
#  name            :string(255)
#  championship_id :integer(4)
#

