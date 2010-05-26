class Player < ActiveRecord::Base
  belongs_to :team
  belongs_to :country
end

# == Schema Information
#
# Table name: players
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  born_at    :datetime
#  country    :string(255)
#  team_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  bio        :text
#

