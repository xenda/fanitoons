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
