class Folder < ActiveRecord::Base    
  belongs_to :owner, :class_name => "Account", :foreign_key => "account_id"
  belongs_to :account
  
  has_many :messages, :order => "created_at DESC", :dependent => :destroy


  def siblings
    owner.folders
  end
  def has_no_messages 
    messages.size == 0
  end
end

# == Schema Information
#
# Table name: folders
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)
#  account_id   :integer(4)
#  deletable    :boolean(1)      default(FALSE)
#  folder_type  :string(255)
#  lock_version :integer(4)      default(0)
#  created_at   :datetime
#  updated_at   :datetime
#

