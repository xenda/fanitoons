class Post < ActiveRecord::Base
  
  belongs_to :admin, :class_name => "Admin", :foreign_key => "account_id"
  has_many :comments, :as => :commentable
  
  validates_presence_of :title
  validates_presence_of :content
  
  has_attached_file :picture, :styles => { :medium => "300x300", :thumb => "50x50>", :home => "275x92#", :post => "630x150#", :small_post=>"630x100#" },:path => ":rails_root/public/system/posts/:attachment/:id/:style.:extension", :url => "/system/posts/:attachment/:id/:style.:extension"


  #record_activity_of :admin, :actions => [:create, :update]
    
  before_save :create_slug
  
  def to_param
    if title
      "#{id}-#{title.parameterize}"
    else
      "#{id}"
    end
  end
  
  def name
    title
  end
  
  private
  
  def create_slug
    self.slug = self.title.parameterize if self.title
  end
  
end




# == Schema Information
#
# Table name: posts
#
#  id                   :integer(4)      not null, primary key
#  title                :string(255)
#  content              :text
#  created_at           :datetime
#  updated_at           :datetime
#  account_id           :integer(4)
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer(4)
#  picture_updated_at   :datetime
#  slug                 :string(255)
#  published_at         :datetime
#

