class Admin::CommentsController < InheritedResources::Base
  
  layout "admin"
  before_filter :authenticate_account!
  
  def create
    create! { admin_comments_path }
  end
  
  def update
    update! { admin_comments_path }
  end
  
  def collection
    @comments ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10)
  end
  
end