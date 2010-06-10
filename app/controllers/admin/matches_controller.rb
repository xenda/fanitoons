class Admin::MatchesController < InheritedResources::Base
  
  layout "admin"
  before_filter :authenticate_admin!
  
  def create
    create! { admin_matches_path }
  end
  
  def update
    update! { admin_matches_path }
  end
  
  def collection
    @matches ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10), :order => "created_at DESC"
  end
  
end