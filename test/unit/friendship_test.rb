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
#  account_id :integer
#  friend_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

