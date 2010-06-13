class Avatar < ActiveRecord::Base
 belongs_to :account, :foreign_key => "user_id"
 has_many :comments, :as => :commentable

record_activity_of :account, :actions => [:create, :update, :destroy]
 
 has_one :shirt
 has_one :short
 has_one :snicker
 
 
 def name
  "Avatar de #{account.name}"
 end
end

# == Schema Information
#
# Table name: avatars
#
#  id               :integer         not null, primary key
#  user_id          :integer
#  shirt_id         :integer
#  short_id         :integer
#  snicker_id       :integer
#  shirt_rotation   :integer
#  short_rotation   :integer
#  snicker_rotation :integer
#  shirt_scale      :integer
#  short_scale      :integer
#  snicker_scale    :integer
#  created_at       :datetime
#  updated_at       :datetime
#

