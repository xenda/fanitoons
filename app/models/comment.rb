class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :account, :class_name => "Account", :foreign_key => "user_id"
  
  validates_presence_of :commentable_id
  validates_presence_of :content
  validates_presence_of :email
  
  record_activity_of :account, :actions => [:create, :update]
  
  before_save :add_name
  
  
  def add_name
    return if self.name
    self.name = self.email
  end
  
end



# == Schema Information
#
# Table name: comments
#
#  id               :integer(4)      not null, primary key
#  post_id          :integer(4)
#  title            :string(255)
#  content          :text
#  email            :string(255)
#  user_id          :string(255)
#  website          :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  commentable_id   :integer(4)
#  commentable_type :string(255)
#  name             :string(255)
#

