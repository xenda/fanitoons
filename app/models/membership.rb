class Membership < ActiveRecord::Base

  belongs_to :gang
  belongs_to :account, :class_name => "Account", :foreign_key => "user_id"
  
  record_activity_of :account
  
  include AASM
  aasm_column :state
  aasm_initial_state :pending
  aasm_state :pending, :enter => :make_activation_code
  aasm_state :active, :enter => :do_activate
  aasm_state :invited
  
  aasm_event :activate do
    transitions :from => :pending, :to => :active
  end
  aasm_event :invite do
    transitions :from => :pending, :to => :invited
  end
  aasm_event :accept_invitation do
    transitions :from => :invited, :to => :active
  end
  
  def active?
    self.state == 'active'
  end
  
  protected  
  
  def make_activation_code
    self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end  
  
  def do_activate
    self.activated_at = Time.now.utc
    self.activation_code = nil
  end
  
end

# == Schema Information
#
# Table name: memberships
#
#  id              :integer         not null, primary key
#  user_id         :integer
#  group_id        :integer
#  moderator       :boolean         default(FALSE)
#  state           :string(255)
#  activation_code :string(40)
#  activated_at    :datetime
#  created_at      :datetime
#  updated_at      :datetime
#

