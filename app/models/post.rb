class Post < ActiveRecord::Base
  
  belongs_to :account
  has_many :comments
  
  validates_presence_of :title
  validates_presence_of :content
  
end
