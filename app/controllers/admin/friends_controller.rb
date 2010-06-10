class Admin::FriendsController < InheritedResources::Base
  
  layout "admin"
  before_filter :authenticate_admin!
  
  def create
    create! { admin_friends_path }
  end
  
  def update
    update! { admin_friends_path }
  end
  
  def collection
    @friends ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10)
  end
  
end