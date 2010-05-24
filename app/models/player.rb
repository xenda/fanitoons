class Player < ActiveRecord::Base
  belongs_to :team
  belongs_to :country
end
