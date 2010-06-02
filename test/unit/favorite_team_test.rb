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
#  id         :integer         not null, primary key
#  team_id    :integer
#  account_id :integer
#  created_at :datetime
#  updated_at :datetime
#

