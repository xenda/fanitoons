class Admin::AvatarsController < InheritedResources::Base
  
  layout "admin"
  before_filter :authenticate_account!
  
  def create
    create! { admin_avatars_path }
  end
  
  def update
    update! { admin_avatars_path }
  end
  
  def collection
    @avatars ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10)
  end
  
end