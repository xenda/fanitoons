class Stadium < ActiveRecord::Base
  has_many :matches
  belongs_to :country
end
