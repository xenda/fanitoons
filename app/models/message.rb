class Message < ActiveRecord::Base

  belongs_to :folder
  has_many :comments, :as=> :commentable
  belongs_to :from, :class_name => "Account", :foreign_key => "from_account_id"
  belongs_to :to,   :class_name => "Account", :foreign_key => "to_account_id"
  
  named_scope :unread, :conditions => ["is_read = ?", false]
  named_scope :read, :conditions => ["is_read = ?", true]
  
  validates_presence_of :folder
  validates_presence_of :from
  validates_presence_of :to

  acts_as_abusable
  
  def read!
    update_attribute(:is_read, true)
  end
  def read?
    is_read?
  end

  def unread!
    update_attribute(:is_read, false)
  end
  def unread?
    !read?
  end

  def date
    I18n.l(created_at, :format => :short)
  end
  def dispatch!
    copy = self.clone
    copy.folder = self.from.outbox
    logger.info copy.class
    logger.info copy.valid?
    logger.info copy.errors.full_messages
    copy.save!
    copy.read!
    
    self.folder = self.to.inbox
    self.save!
    
    MessageMailer.deliver_email_copy(self)
  end
end

# == Schema Information
#
# Table name: messages
#
#  id              :integer(4)      not null, primary key
#  subject         :string(255)
#  content         :text
#  folder_id       :integer(4)
#  is_read         :boolean(1)      default(FALSE)
#  from_account_id :integer(4)
#  to_account_id   :integer(4)
#  created_at      :datetime
#  updated_at      :datetime
#

