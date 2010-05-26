class Account < ActiveRecord::Base
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :name, :fb_token, :role, :gender, :fb_id, :surname, :picture
  
  NEW_ACCOUNT = "new"
  EXISTING_ACCOUNT = "existing" 
  WRONG_ACCOUNT = "wrong_data"
  
  devise :registerable, :database_authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :validatable, :invitable, :encryptor => :bcrypt
  
  
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

  has_one :avatar
  has_many :predictions, :foreign_key => "user_id"
  
  # Paperclip::Interpolations::RAILS_ROOT = "."
  # Paperclip::Storage::S3::RAILS_ENV = PADRINO_ENV
  
    has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "50x50>" }
    # ,
    #                    :storage => :s3,
    #                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
    #                    :path => ":attachment/:id/:style.:extension"
    


   def has_predicted_match?(match)
     not prediction_for_match(match).empty?
   end

   def prediction_for_match(match)
     self.predictions.find(:all,:conditions=>{:match_id=>match.id})
   end

  
  ##
  # This method is for authentication purpose
  #
  # def self.authenticate(email, password)
  #   account = first(:conditions => { :email => email }) if email.present?
  #   account && account.password_clean == password ? account : nil
  # end
  

  def self.authenticate_from_facebook(user,access_token)
    
    # We look for the user's account in the database 
    account = Account.find_by_email(user["email"])
    
    logger.info "Authenticating from Facebook"
    
    #If it exists...
    if account

      logger.info "Account exists"
      
      # We see if it's updated. If not, we update it
      if (not account.fb_id) or (not account.fb_token) or (not account.gender) or (not account.confirmed_at)
        account.fb_id = user["id"]
        account.fb_token = access_token
        account.gender = user["gender"]
        account.confirmed_at ||= Time.zone.now
        account.save
        logger.info "Account was old and upgraded"
      end
    
      logger.info account.inspect
      logger.info "Errors:"
      logger.info account.errors
      # We return it as complete
      [EXISTING_ACCOUNT,account]
      
    else
      
      surname = (user["middle_name"] || "") + (user["last_name"]||"")

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
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  surname              :string(255)
#  email                :string(255)     default(""), not null
#  crypted_password     :string(255)
#  salt                 :string(255)
#  role                 :string(255)
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  fb_token             :string(255)
#  fb_id                :integer
#  gender               :string(255)
#  encrypted_password   :string(128)     default("")
#  password_salt        :string(255)     default("")
#  confirmation_token   :string(255)
#  confirmed_at         :datetime
#  confirmation_sent_at :datetime
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  invitation_token     :string(20)
#  invitation_sent_at   :datetime
#

