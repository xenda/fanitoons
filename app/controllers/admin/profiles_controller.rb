class Admin::ProfilesController < InheritedResources::Base
  
  layout "admin"
  before_filter :authenticate_account!
  
  def create
    create! { admin_profiles_path }
  end
  
  def update
    update! { admin_profiles_path }
  end
  
  def collection
    @profiles ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10), :order => "created_at DESC"
  end
  
end