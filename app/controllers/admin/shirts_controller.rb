class Admin::ShirtsController < InheritedResources::Base
  
  layout "admin"
  before_filter :authenticate_account!
  
  def create
    create! { admin_shirts_path }
  end
  
  def update
    update! { admin_shirts_path }
  end
  
  def collection
    @shirts ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10), :order => "created_at DESC"
  end
  
end