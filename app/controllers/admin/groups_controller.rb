class Admin::GroupsController < InheritedResources::Base
  
  layout "admin"
  before_filter :authenticate_admin!
  
  def create
    create! { admin_groups_path }
  end
  
  def update
    update! { admin_groups_path }
  end
  
  def collection
    @groups ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10)
  end
  
end