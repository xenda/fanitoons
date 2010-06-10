class Admin::PostImagesController < InheritedResources::Base
  
  layout "admin"
  before_filter :authenticate_admin!
  
  def create
    create! { admin_post_images_path }
  end
  
  def update
    update! { admin_post_images_path }
  end
  
  def collection
    @post_images ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10), :order => "created_at DESC"
  end
  
end