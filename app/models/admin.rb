class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :confirmable, :lockable, :timeoutable and :activatable
  devise :registerable, :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
  
  has_many :posts, :class_name => "Post", :foreign_key => "account_id"
  
end

# == Schema Information
#
# Table name: admins
#
#  id                 :integer         not null, primary key
#  email              :string(255)     default(""), not null
#  encrypted_password :string(128)     default(""), not null
#  password_salt      :string(255)     default(""), not null
#  sign_in_count      :integer         default(0)
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :string(255)
#  last_sign_in_ip    :string(255)
#  failed_attempts    :integer         default(0)
#  unlock_token       :string(255)
#  locked_at          :datetime
#  created_at         :datetime
#  updated_at         :datetime
#

# == Schema Information
#
# Table name: admins
#
#  id                  :integer         not null, primary key
#  email               :string(255)     default(""), not null
#  encrypted_password  :string(128)     default(""), not null
#  password_salt       :string(255)     default(""), not null
#  sign_in_count       :integer         default(0)
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :string(255)
#  last_sign_in_ip     :string(255)
#  failed_attempts     :integer         default(0)
#  unlock_token        :string(255)
#  locked_at           :datetime
#  created_at          :datetime
#  updated_at          :datetime
#  remember_token      :string(255)
#  remember_created_at :datetime
#

