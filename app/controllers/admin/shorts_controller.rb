class Admin::ShortsController < InheritedResources::Base
  
  layout "admin"
  before_filter :authenticate_admin!
  
  def create
    create! { admin_shorts_path }
  end
  
  def update
    update! { admin_shorts_path }
  end
  
  def collection
    @shorts ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10)
  end
  
end