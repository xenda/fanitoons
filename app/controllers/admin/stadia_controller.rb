class Admin::StadiaController < InheritedResources::Base
  
  layout "admin"
  before_filter :authenticate_admin!
  
  def create
    create! { admin_stadia_path }
  end
  
  def update
    update! { admin_stadia_path }
  end
  
  def collection
    @stadia ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10)
  end
  
end