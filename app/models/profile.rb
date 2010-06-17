class Profile < ActiveRecord::Base

  belongs_to :account

  has_many :friendships_by_others, :class_name => "Friendship", :foreign_key => 'invited_id', :conditions => "status = #{Friendship::ACCEPTED}"
  has_many :friendships_by_me, :class_name => "Friendship", :foreign_key => 'inviter_id', :conditions => "status = #{Friendship::ACCEPTED}"

  has_many :follower_friendships, :class_name => "Friendship", :foreign_key => "invited_id", :conditions => "status = #{Friendship::PENDING}"
  has_many :following_friendships, :class_name => "Friendship", :foreign_key => "inviter_id", :conditions => "status = #{Friendship::PENDING}"

  has_many :friends_by_others,  :through => :friendships_by_others, :source => :inviter
  has_many :friends_by_me, :through => :friendships_by_me, :source => :invited

  has_many :followers, :through => :follower_friendships, :source => :inviter
  has_many :followings, :through => :following_friendships, :source => :invited

  acts_as_abusable

  named_scope :active, :conditions => ['accounts.email is not null'], :include => :account

  def self.site_search(query, search_options={})
    q = "%#{query}%"
    Profile.active.find(:all, :conditions => ["first_name like ? or last_name like ? or login like ?", q, q, q])
  end

  def network
    friends + followings
  end

  def friends
    # Reload associations just to make sure we're working with the current staff. Bad smell!
    # todo check this... if we don't should reload the relationship to get the test working...
    (friends_by_others(true) + friends_by_me(true)).uniq
  end

  def friendships
    (friendships_by_others(true) + friendships_by_me(true)).uniq
  end

  def full_name
     #todo apply for internationalization
     first_name.blank? && last_name.blank? ? self.account.email : "#{first_name} #{last_name}".strip
  end

  def followed_by? profile
    followers(true).include?(profile) || is_friend_of?(profile)
  end

  def follows? profile
    followings(true).include?(profile) || is_friend_of?(profile)
  end

  def is_friend_of? profile
    friends.include?(profile)
  end

  def is_related_to? profile
    me.followed_by?(profile) || me.follows?(profile) || me.is_friend_of?(profile)
  end

  def add_follower(follower)
    if follower.follows? me
      return false
    elsif me.follows? follower
      return add_friend(follower)
    else
      return Friendship.add_follower(follower, me)
    end
  end

  def add_following(following)
    following.add_follower(me)
  end

  def add_friend(friend)
    return false if friend.is_friend_of? me

    relationship = if friend.follows? me
      find_friendship(friend, me, Friendship::PENDING)
    elsif friend.followed_by? me
      find_friendship(me, friend, Friendship::PENDING)
    else
      Friendship.create(:inviter => friend, :invited => me, :status => Friendship::PENDING)
    end
    relationship.accept!
    # todo enable send_friendships_notifications? setting per profile
    # FriendshipMailer.deliver_frienship_validated(relationship.inviter, relationship.invited) if relationship.inviter.send_friendships_notifications?
    #FriendshipMailer.deliver_friendship_validated(relationship.inviter, relationship.invited)
    return true
  end

  def remove_friend(friend)
    relationships = me.friendships.select{|f| f.inviter == friend  || f.invited == friend }
    destroy_relationships(relationships)
  end

  def remove_follower(friend)
    friends = is_friend_of? friend
    relationships = me.follower_friendships.select{|f| f.inviter == friend}
    destroy_relationships(relationships)
    if friends
      remove_friend(friend)
      add_following(friend)
    end
  end

  def remove_following(friend)
    friend.remove_follower(me)
  end

  private
  def destroy_relationships(relationships)
    # todo maybe we need to save this somewhere to keep historical records?
    relationships.each{|r| r.destroy}
  end

  # Freud will be happy.
  def me
    self
  end

  def find_friendship(inviter, invited, status)
     conditions = {:inviter_id => inviter.id, :invited_id => invited.id}
     conditions.merge!(:status => status) if status
     Friendship.find(:first, :conditions => conditions)
  end


end


# == Schema Information
#
# Table name: profiles
#
#  id         :integer(4)      not null, primary key
#  account_id :integer(4)
#  first_name :string(255)
#  last_name  :string(255)
#  website    :string(255)
#  blog       :string(255)
#  icon       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

