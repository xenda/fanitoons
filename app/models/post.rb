class Post < ActiveRecord::Base
  
  belongs_to :account
  has_many :comments
  
  validates_presence_of :title
  validates_presence_of :content
  
  has_attached_file :picture, :styles => { :medium => "300x300", :thumb => "50x50>" }
  
  before_save :create_slug
  
  def name
    "title"
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
#  id                   :integer         not null, primary key
#  title                :string(255)
#  content              :text
#  created_at           :datetime
#  updated_at           :datetime
#  account_id           :integer
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  slug                 :string(255)
#

