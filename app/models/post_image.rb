class PostImage < ActiveRecord::Base
  belongs_to :post
  has_attached_file :picture, :styles => { :medium => "300x300", :thumb => "50x50>" }
  
end
