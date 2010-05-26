class Country < ActiveRecord::Base
  has_many :stadia
end

# == Schema Information
#
# Table name: countries
#
#  id   :integer         not null, primary key
#  name :string(255)
#

