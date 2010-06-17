class Avatar < ActiveRecord::Base
 belongs_to :account, :foreign_key => "user_id"
 has_many :comments, :as => :commentable

record_activity_of :account, :actions => [:create, :update, :destroy]
 
 belongs_to :shirt
 belongs_to :short
 belongs_to :snicker
 
 
 def name
  "Avatar de #{account.name}"
 end
end


# == Schema Information
#
# Table name: avatars
#
#  id               :integer(4)      not null, primary key
#  user_id          :integer(4)
#  shirt_id         :integer(4)
#  short_id         :integer(4)
#  snicker_id       :integer(4)
#  shirt_rotation   :integer(4)
#  short_rotation   :integer(4)
#  snicker_rotation :integer(4)
#  shirt_scale      :integer(4)
#  short_scale      :integer(4)
#  snicker_scale    :integer(4)
#  created_at       :datetime
#  updated_at       :datetime
#

