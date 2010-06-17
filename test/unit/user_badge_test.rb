require 'test_helper'

class UserBadgeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
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

