require 'test_helper'

class ChampionshipTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: championships
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  started_at  :datetime
#  finished_at :datetime
#  description :text
#  place       :string(255)
#  winner_id   :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

