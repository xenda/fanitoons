class UserBadge < ActiveRecord::Base
  
  belongs_to :account, :class_name => "Account", :foreign_key => "user_id"
  belongs_to :badge
  
end


# == Schema Information
#
# Table name: user_badges
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  badge_id   :integer(4)
#  earned_at  :datetime
#  points     :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

