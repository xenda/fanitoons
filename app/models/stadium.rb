class Stadium < ActiveRecord::Base
  has_many :matches
  belongs_to :country
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

