require 'test_helper'

class FavoriteTeamTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: favorite_teams
#
#  id         :integer(4)      not null, primary key
#  team_id    :integer(4)
#  account_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

