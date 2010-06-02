class Admin::MatchesController < InheritedResources::Base
  
  
  def update
    update! { admin_matches_path }
  end
  
  def create
    create! { admin_matches_path }
  end
  
  def collection
    @matches ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10), :order => "played_at"
  end
  
end