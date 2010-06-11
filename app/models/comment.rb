class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :account, :class_name => "Account", :foreign_key => "user_id"
end


# == Schema Information
#
# Table name: comments
#
#  id               :integer         not null, primary key
#  post_id          :integer
#  title            :string(255)
#  content          :text
#  email            :string(255)
#  user_id          :string(255)
#  website          :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  commentable_id   :integer
#  commentable_type :string(255)
#

