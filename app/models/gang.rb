class Gang < ActiveRecord::Base

  belongs_to :author, :class_name => 'Account', :foreign_key => 'user_id'

  has_many :memberships, :dependent => :destroy

  has_many :moderator_memberships, :class_name => 'Membership',
                                   :conditions => ['memberships.moderator = ?', true]

  has_many :members,    :through => :memberships, :source => :account,
                        :conditions => ['memberships.state = ?', 'active']

  has_many :pending_members,  :through => :memberships, :source => :account,
                              :conditions => ['memberships.state = ?', 'pending']

  has_many :moderators, :through => :moderator_memberships, :source => :account,
                        :conditions => ['memberships.state = ?', 'active']
                        
  # has_many :sharings, :class_name => 'Share', :dependent => :destroy, :as => :shared_to
  

  has_many :invited_members,  :through => :memberships, :source => :account, :conditions => ['memberships.state = ?', 'invited']
  named_scope :can_invite, :include => :memberships, 
                           :conditions => ["memberships.state='active' and gangs.state='active' and(memberships.moderator = ? or gangs.moderated = ?)", true, false]  
  
  
   before_create :set_default_image

    has_attached_file :image, {
      :url => "/system/:class/:attachment/:id/:style_:basename.:extension",
      :styles => { 
        :big    => "128x128#",
        :medium => "72x72#",
        :small  => "25x25#",
        :tiny   => "12x12#"
      }}
      
      attr_accessor :image_file_name
      attr_accessor :image_content_type
      attr_accessor :image_file_size
      attr_accessor :image_updated_at
       
  
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :author

  record_activity_of :author
  acts_as_abusable
  acts_as_taggable

  include AASM
  aasm_column :state
  aasm_initial_state :pending
  aasm_state :pending, :enter => :make_activation_code
  aasm_state :active,  :enter => :do_activate
  aasm_event :activate do
    transitions :from => :pending, :to => :active
  end

  named_scope :public, :conditions => {:private => false}
  named_scope :private, :conditions => {:private => true}
  named_scope :active, :conditions => {:state => 'active'}
  
  def self.site_search(query, search_options={})
    Gang.active.find(:all, :conditions => ["name like ?", "%#{query}%"])
  end

  def membership_of(user)
    mem = memberships.select{|m| m.account == user}
    return mem.first unless mem.blank?
  end

  def activate_membership(user)
    mem = membership_of(user)
    mem.activate! if mem && mem.pending?
  end

  def grant_moderator(user)
    moderator_privileges(user,true)
  end

  def revoke_moderator(user)
    moderator_privileges(user,false)
  end

  def moderator_privileges(user, grant=false)
    mem = membership_of(user)
    mem.moderator = grant
    mem.save!
  end

  def join(user,moderator=false)
    # todo Confirm what to do if th user is already a member. By now just ignore it and continue.
    mem = membership_of(user)
    mem = self.memberships.build(:account => user, :moderator => moderator) unless mem
    mem.save!
    grant_moderator(user) if moderator
    mem.activate! unless self.moderated?
  end
  
  def private?
    self.send(:private)
  end

  def leave(user)
    mem = membership_of(user)
    mem.destroy if mem
  end

  def is_banned(user)
    raise "Implement this..."
  end

  def ban(user)
    raise "Implement this..."
  end
  
  # def share(user, shareable_type, shareable_id)
  #   params = {:shareable_type => shareable_type, :shareable_id => shareable_id}   
  #   return if self.sharings.find :first, :conditions => params
  #   self.sharings.create params.merge!({:user_id => user.id})
  # end
  # 
  # def shared?(object)
  #   params = {:shareable_type => object.class.to_s, :shareable_id => object.id} 
  #   self.sharings.count(:conditions => params)  > 0
  # end  
  
  def creation_date(format=:short)
    I18n.l(self.created_at, :format => format)
  end
  
  def invite(user)
    mem = membership_of(user)
    mem = self.memberships.build(:account => user) unless mem
    mem.save!
    mem.invite!
  end
  
  def accept_invitation(user)
    mem = membership_of(user)
    mem.accept_invitation! if mem && mem.invited?
  end
  
  def can_invite?(user)
    return (self.moderators.include?(user) or (self.members.include?(user) and self.moderated==false))
  end
  
  protected
  def make_activation_code
    self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end

  def do_activate
    self.activated_at = Time.now.utc
    self.activation_code = nil
    self.moderator_memberships.each{|mod| mod.activate! unless mod.active?}
  end


  def set_default_image
    unless self.image?
        default_group_image = File.join(RAILS_ROOT, 'public', 'images', "default_group.png")
        self.image = File.new(default_group_image)
    end
  end
  
end


# == Schema Information
#
# Table name: gangs
#
#  id              :integer(4)      not null, primary key
#  name            :string(255)
#  description     :string(255)
#  image           :string(255)
#  state           :string(255)
#  private         :boolean(1)
#  moderated       :boolean(1)      default(FALSE)
#  user_id         :integer(4)
#  activation_code :string(40)
#  activated_at    :datetime
#  created_at      :datetime
#  updated_at      :datetime
#

