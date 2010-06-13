class Friendship < ActiveRecord::Base
  
  belongs_to :account
  belongs_to :friend, :class_name => "Account", :foreign_key => "friend_id"
  
  record_activity_of :account, :actions => [:create, :update]
  
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

