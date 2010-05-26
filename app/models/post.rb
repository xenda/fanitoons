class Post < ActiveRecord::Base
  
  belongs_to :account
  has_many :comments
  
  validates_presence_of :title
  validates_presence_of :content
  
end

# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#  account_id :integer
#

