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
#  id         :integer         not null, primary key
#  user_id    :integer
#  badge_id   :integer
#  earned_at  :datetime
#  points     :integer
#  created_at :datetime
#  updated_at :datetime
#

