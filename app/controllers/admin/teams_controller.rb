class Admin::TeamsController < InheritedResources::Base
  
  layout "admin"
  before_filter :authenticate_account!
  
  def create
    create! { admin_teams_path }
  end
  
  def update
    update! { admin_teams_path }
  end
  
  def collection
    @teams ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10)
  end
  
end