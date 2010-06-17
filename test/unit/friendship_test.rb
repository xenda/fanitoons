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
#  id         :integer(4)      not null, primary key
#  inviter_id :integer(4)
#  invited_id :integer(4)
#  status     :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

