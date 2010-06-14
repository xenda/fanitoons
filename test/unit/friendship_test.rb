require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: friendships
#
#  id         :integer         not null, primary key
#  inviter_id :integer
#  invited_id :integer
#  status     :integer
#  created_at :datetime
#  updated_at :datetime
#

