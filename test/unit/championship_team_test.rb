require 'test_helper'

class ChampionshipTeamTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: championship_teams
#
#  id              :integer(4)      not null, primary key
#  team_id         :integer(4)
#  championship_id :integer(4)
#  created_at      :datetime
#  updated_at      :datetime
#

