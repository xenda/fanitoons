require 'ftools'

class Account < ActiveRecord::Base
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :name, :fb_token, :role, :gender, :fb_id, :surname, :picture, :remember_me, :title
  
  NEW_ACCOUNT = "new"
  EXISTING_ACCOUNT = "existing" 
  WRONG_ACCOUNT = "wrong_data"
  
  devise :registerable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :invitable, :encryptor => :bcrypt
  
    
  # Validations
  # validates_presence_of     :email, :role
  # validates_presence_of     :password,                   :if => :password_required
  # validates_presence_of     :password_confirmation,      :if => :password_required
  # validates_length_of       :password, :within => 4..40, :if => :password_required
  # validates_confirmation_of :password,                   :if => :password_required
  # validates_length_of       :email,    :within => 3..100
  # validates_uniqueness_of   :email,    :case_sensitive => false
  # 
  # validates_format_of       :email,    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  # validates_format_of       :role,     :with => /[A-Za-z]/

  # Callbacks
  # before_save :generate_password

  has_one :avatar, :foreign_key => "user_id"
  has_many :predictions, :foreign_key => "user_id"
  
  has_many :favorite_teams, :class_name => "FavoriteTeam", :foreign_key => "account_id"
  has_many :teams, :through => :favorite_teams
  has_many :user_badges, :class_name => "UserBadge", :foreign_key => "user_id"
  has_many :badges, :through => :user_badges
  
  
  before_create :create_profile

  has_one :profile, :dependent => :destroy

  has_many :memberships, :dependent => :destroy
  has_many :plain_memberships, :class_name => 'Membership',
                               :conditions => ['memberships.moderator <> ?', true]
  has_many :moderator_memberships, :class_name => 'Membership',
                                   :conditions => ['memberships.moderator = ?', true]

  has_many :gangs, :through => :memberships,
                    :conditions => "memberships.state='active' and gangs.state='active'"

  has_many :moderated_groups, :through => :moderator_memberships,
                    :conditions => "memberships.state='active' and gangs.state='active'", :source => :group



  has_one :inbox, :class_name => "Folder", :foreign_key => "account_id", :conditions => ["folder_type = 'Entrada'"]
  has_one :outbox, :class_name => "Folder", :foreign_key => "account_id", :conditions => ["folder_type = 'Salida'"]

  has_many :folders, :dependent => :destroy
  has_many :sent_messages, :class_name => "Message", :foreign_key => "from_account_id", :dependent => :destroy
  has_many :received_messages, :class_name => "Message", :foreign_key => "to_account_id", :dependent => :destroy

  after_save :create_default_folders!

  # has_many :sharings, :class_name => 'Share', :dependent => :destroy

  accepts_nested_attributes_for :profile
  attr_accessible :profile_attributes

  attr_accessor :tmp_upload_dir
  after_create  :clean_tmp_upload_dir


  # handle new param
    def fast_asset=(file)
      if file && file.respond_to?('[]')
        logger.info "Analizando.."
        logger.info "file['original_name'] =~ /^CAM_/ = #{file['original_name'] =~ /^CAM_/}"
        if file['original_name'] =~ /^CAM_/
          logger.info "Caso especial"
          self.tmp_upload_dir = "#{RAILS_ROOT}/public"
          tmp_file_path = "#{self.tmp_upload_dir}/#{file['original_name']}"
        else
          logger.info "Caso normal"
          self.tmp_upload_dir = "#{file['filepath']}_1"
          tmp_file_path = "#{self.tmp_upload_dir}/#{file['original_name']}"
        end
        
        FileUtils.mkdir_p(self.tmp_upload_dir)
        FileUtils.mv(file['filepath'], tmp_file_path)
        self.picture = File.new(tmp_file_path)
        self.thumbnail = File.new(tmp_file_path)
      end
    end    



  def network
    profile.network.collect{|profile| profile.user}
  end
  
  # Paperclip::Interpolations::RAILS_ROOT = "."
  # Paperclip::Storage::S3::RAILS_ENV = PADRINO_ENV
  
    has_attached_file :picture, :styles => { :medium => ["300x300",:png], :profile=>["200x300",:png] },:path => ":rails_root/public/system/accounts/:attachment/:id/:style.:extension", :url => "/system/accounts/:attachment/:id/:style.:extension"

    has_attached_file :thumbnail, :styles => { :thumb => ["67x67",:png]},:path => ":rails_root/public/system/thumbnails/:attachment/:id/:style.:extension", :url => "/system/thumbnails/:attachment/:id/:style.:extension", :processors => [:carnetsize]
    
    
    # ,
    #                    :storage => :s3,
    #                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
    #                    :path => ":attachment/:id/:style.:extension"
    

    def self.update_titles
      #
    end


    def self.top_times
      Account.find(:all, :select => "accounts.*, (select sum(points) from user_badges where user_badges.user_id = accounts.id) as points", :order => "points desc", :limit => 5 )
    end
    
    def self.top_season
      Account.find(:all, :select =>"accounts.*, (select sum(points) from user_badges where user_badges.user_id = accounts.id ) as points", :order => "points desc", :limit => 5)
    end

    def score
      @score ||= self.user_badges.sum(:points)
    end

    def fast_asset=(file)
          if file && file.respond_to?('[]')
            logger.info "Analizando.."
            logger.info "file['original_name'] =~ /^CAM_/ = #{file['original_name'] =~ /^CAM_/}"
            if file['original_name'] =~ /^CAM_/
              logger.info "Caso especial"
              self.tmp_upload_dir = "#{RAILS_ROOT}/public"
              tmp_file_path = "#{self.tmp_upload_dir}/#{file['original_name']}"
            else
              logger.info "Caso normal"
              self.tmp_upload_dir = "#{file['filepath']}_1"
              tmp_file_path = "#{self.tmp_upload_dir}/#{file['original_name']}"
            end
            
        FileUtils.mkdir_p(self.tmp_upload_dir)
        FileUtils.mv(file['filepath'], tmp_file_path)
        self.picture = File.new(tmp_file_path)
        self.thumbnail = File.new(tmp_file_path)
      end
    end

    def self.save_upload(file)
      
      require 'uri'
      
      id = URI.escape(Time.zone.now.to_s.parameterize)
      logger.info "Id: #{id}"
      path = "#{RAILS_ROOT}/public/system/tempuploads"
      logger.info "Ruta: #{path}"
      
      tmp_upload_dir = "#{file['filepath']}_1"
      original_name = file['original_name']
      extension = original_name[-4..-1]
      original_name = original_name[0..5].parameterize
      
      tmp_file_path = "#{tmp_upload_dir}/#{original_name}-#{id}#{extension}"
      
      FileUtils.mkdir_p(tmp_upload_dir)
      FileUtils.mv(file['filepath'],tmp_file_path)
      
      f = File.new(tmp_file_path)
  
      FileUtils.makedirs(path)
      File.open("#{path}/#{original_name}#{id}#{extension}","wb"){ |stream| stream.write(f.read)}
      result = "system/tempuploads/#{original_name}#{id}#{extension}"
      logger.info result
      result
    end
    
    def get_avatar
      return self.avatar if self.avatar
      return self.build_avatar 
    end
    
    def self.extension(file)
      file.original_filename.split(".").last
    end


   def has_predicted_match?(match)
     not prediction_for_match(match).empty?
   end

   def prediction_for_match(match)
     self.predictions.find(:all,:conditions=>{:match_id=>match.id})
   end
   
   def right_predictions_average
     right = self.right_predictions_count.to_f
     right ||= 0.0
     total = self.predictions.size
     
     if total > 0
          ( right / total ).round(2)
     else
          0
      end
   end

  def future_predictions(limit=3,future=3.months.from_now)
    self.predictions.find(:all,:include=>[:match],:conditions=>{:matches=>{:played_at=>Time.zone.now..future}},:limit=>limit)
  end
  
  def past_predictions(limit=3)
    self.predictions.find(:all, :include=>[:match], :conditions=>["matches.played_at < ?",Time.zone.now], :limit=>limit)
  end
  
  def right_predictions
   @right_predictions ||= self.predictions.find(:all, :include=>[:match], :conditions=>"matches.first_team_goals like predictions.first_team_result and matches.second_team_goals like predictions.second_team_result")
  end
  
  def right_predictions_count
    @right_predictions_count ||= self.predictions.count(:all, :include=>[:match], :conditions=>"matches.first_team_goals like predictions.first_team_result and matches.second_team_goals like predictions.second_team_result")    
  end
  
  def wrong_predictions
   @wrong_predictions ||= self.predictions.find(:all, :include=>[:match], :conditions=>"matches.first_team_goals not like predictions.first_team_result and matches.second_team_goals not like predictions.second_team_result")
  end
  
  def wrong_predictions_count
   @wrong_predictions_count ||= self.predictions.count(:all, :include=>[:match], :conditions=>"matches.first_team_goals not like predictions.first_team_result and matches.second_team_goals not like predictions.second_team_result")
  end  
  
  def close_predictions
   @close_predictions ||= self.predictions.find(:all, :include=>[:match], :conditions=>"(matches.first_team_goals -  predictions.first_team_result) <= 1 and (matches.second_team_goals - predictions.second_team_result) <= 1")
  end

  def close_predictions_count
   @close_predictions_count ||= self.predictions.count(:all, :include=>[:match], :conditions=>"(matches.first_team_goals -  predictions.first_team_result) <= 1 and (matches.second_team_goals - predictions.second_team_result) <= 1")
  end
  
  def almost_close_predictions
   @almost_close_predictions ||= self.predictions.find(:all, :include=>[:match], :conditions=>"(matches.first_team_goals -  predictions.first_team_result) <= 2 and (matches.second_team_goals - predictions.second_team_result) <= 2")
  end

  def almost_close_predictions_count
   @almost_close_predictions_count ||= self.predictions.count(:all, :include=>[:match], :conditions=>"(matches.first_team_goals -  predictions.first_team_result) <= 2 and (matches.second_team_goals - predictions.second_team_result) <= 2")
  end

  
  ##
  # This method is for authentication purpose
  #
  # def self.authenticate(email, password)
  #   account = first(:conditions => { :email => email }) if email.present?
  #   account && account.password_clean == password ? account : nil
  # end
  
  def password_required?
    new_record? || ( no_token? && (!password.nil? || !password_confirmation.nil?) )
  end
  
  def update_with_password(params={})
    current_password = params.delete(:current_password)
    fb_token = params.delete(:fb_token)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = if fb_token or valid_password?(current_password)
      update_attributes(params)
    else
      message = current_password.blank? ? :blank : :invalid
      self.class.add_error_on(self, :current_password, message, false)
      self.attributes = params
      false
    end

    clean_up_passwords unless result
    result
  end
  
  def no_token?
    fb_token.blank? or fb_token.empty? or fb_token.nil?
  end
  
  def from_facebook?
    not (fb_token.blank? or fb_token.empty? or fb_token.nil?)
  end

  def authenticate_from_facebook(user,access_token)
    update_with_facebook(user,access_token)
  end
  
  def update_with_facebook(user,access_token)
    logger.info "Account exists"
    
    # We see if it's updated. If not, we update it
    if (not fb_id) or (not fb_token) or (not gender) or (not confirmed_at)
      self.fb_id = user["id"]
      self.fb_token = access_token
      self.gender = user["gender"]
      self.confirmed_at ||= Time.zone.now
      self.save
      logger.info "Account was old and upgraded"
    end
  end

  def self.authenticate_from_facebook(user,access_token)
    
    # We look for the user's account in the database 
    account = Account.find_by_email(user["email"])
    
    logger.info "Authenticating from Facebook"
    
    #If it exists...
    if account

      account.update_with_facebook(user,access_token)
    
      logger.info account.inspect
      logger.info "Errors:"
      logger.info account.errors
      # We return it as complete
      [EXISTING_ACCOUNT,account]
      
    else
      
      surname = (user["middle_name"] || "") + " " +(user["last_name"]||"")

      require 'base64'
      #If no, we try to create it
      d = Base64.encode64(Time.now.strftime("%d%Y"))
      account = Account.create(:fb_token => access_token, :name => user["first_name"], :surname => surname, :email => user["email"], :role => "user", :fb_id => user["id"], :gender => user["gender"], :password => d, :password_confirmation => d  )
      
      #If it's valid, everything is alright
      if account.valid?
        [NEW_ACCOUNT,account]
        
      #If not, then we say so
      else
        logger.info account.errors.inspect
        [WRONG_ACCOUNT, nil]
        
      end
      
      
    end
    
    
  end

  def full_name
    "#{name} #{surname}"
  end
  
  def to_param
    "#{id}-#{full_name.parameterize}"
  end
  
  def from_facebook?
    fb_token
  end
  
  def title
    "Novato"
  end
  
  

  def get_message(id)
    begin
    sent_messages.find(id)
    rescue
      received_messages.find(id)
    end
  end 

  def create_default_folders!
      default_folders = ["Entrada","Salida"]
      default_folders.each{|folder_type|
        folder_type.strip!
        unless self.folders.find_by_name(folder_type)
          self.folders.create(:name => folder_type, :deletable => false, :folder_type => folder_type)
        end
      }
  end


  
  protected

    def create_profile
      self.profile ||= Profile.new
    end
  
    private
    # clean tmp directory used in handling new param
    def clean_tmp_upload_dir
      FileUtils.rm_r(tmp_upload_dir) if self.tmp_upload_dir && File.directory?(self.tmp_upload_dir)
    end                     
  
  
  ##
  # This method is used for retrive the original password.
  #
  # def password_clean
  #   return "" if fb_token
  #   crypted_password.decrypt(salt)
  # end
  # 
  # private
  #   def generate_password
  #     return if password.blank?
  #     self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
  #     self.crypted_password = password.encrypt(self.salt)
  #   end
  # 
  #   def password_required
  #     return false if fb_token
  #     crypted_password.blank? || !password.blank?
  #   end
end




# == Schema Information
#
# Table name: accounts
#
#  id                     :integer(4)      not null, primary key
#  name                   :string(255)
#  surname                :string(255)
#  email                  :string(255)     default(""), not null
#  crypted_password       :string(255)
#  salt                   :string(255)
#  role                   :string(255)
#  picture_file_name      :string(255)
#  picture_content_type   :string(255)
#  picture_file_size      :integer(4)
#  picture_updated_at     :datetime
#  fb_token               :string(255)
#  fb_id                  :string(255)
#  gender                 :string(255)
#  encrypted_password     :string(128)     default("")
#  password_salt          :string(255)     default("")
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  reset_password_token   :string(255)
#  remember_token         :string(255)
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  invitation_token       :string(20)
#  invitation_sent_at     :datetime
#  birth_date             :date
#  title                  :integer(4)
#  thumbnail_file_name    :string(255)
#  thumbnail_content_type :string(255)
#  thumbnail_file_size    :integer(4)
#  thumbnail_updated_at   :datetime
#

