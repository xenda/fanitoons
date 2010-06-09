class Admin::<%= plural_class_name %>Controller < InheritedResources::Base
  
  layout "admin"
  before_filter :authenticate_account!
  
  def create
    create! { admin_<%= plural_name %>_path }
  end
  
  def update
    update! { admin_<%= plural_name %>_path }
  end
  
  def collection
    @<%= plural_name %> ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10), :order => "created_at DESC"
  end
  
end