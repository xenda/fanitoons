class Avatar < ActiveRecord::Base
 belongs_to :account, :foreign_key => "user_id"
 
end
