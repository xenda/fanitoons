class PostImage < ActiveRecord::Base
  belongs_to :post
  has_attached_file :picture, :styles => { :medium => "300x300", :thumb => "50x50>" },:path => ":rails_root/public/system/post_images/:attachment/:id/:style.:extension", :url => "/system/post_images/:attachment/:id/:style.:extension"
  
end

# == Schema Information
#
# Table name: post_images
#
#  id                   :integer         not null, primary key
#  post_id              :integer
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  created_at           :datetime
#  updated_at           :datetime
#

