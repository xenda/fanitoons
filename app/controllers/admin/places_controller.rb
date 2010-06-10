class Admin::PlacesController < InheritedResources::Base
  
  layout "admin"
  before_filter :authenticate_account!
  
  def create
    create! { admin_places_path }
  end
  
  def update
    update! { admin_places_path }
  end
  
  def collection
    @places ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10)
  end
  
end