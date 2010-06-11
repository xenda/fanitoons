class Admin::PostsController < InheritedResources::Base
  
  layout "admin"
  before_filter :authenticate_admin!
  
  def new
    @post = current_admin.posts.build
    @post.published_at = Time.zone.now
    new!
  end
  
  def create
    create! { admin_posts_path }
  end
  
  def update
    update! { admin_posts_path }
  end
  
  def collection
    @posts ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10)
  end
  
end