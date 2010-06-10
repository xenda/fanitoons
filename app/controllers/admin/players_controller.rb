class Admin::PlayersController < InheritedResources::Base
  
  layout "admin"
  before_filter :authenticate_admin!
  
  def create
    create! { admin_players_path }
  end
  
  def update
    update! { admin_players_path }
  end
  
  def collection
    @players ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10)
  end
  
end