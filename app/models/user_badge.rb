class UserBadge < ActiveRecord::Base
  
  belongs_to :account, :class_name => "Account", :foreign_key => "user_id"
  belongs_to :badge
  
end

# == Schema Information
#
# Table name: user_badges
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  badge_id   :integer
#  earned_at  :datetime
#  points     :integer
#  created_at :datetime
#  updated_at :datetime
#

