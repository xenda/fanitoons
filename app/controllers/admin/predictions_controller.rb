class Admin::PredictionsController < InheritedResources::Base
  
  layout "admin"
  before_filter :authenticate_account!
  
  def create
    create! { admin_predictions_path }
  end
  
  def update
    update! { admin_predictions_path }
  end
  
  def collection
    @predictions ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10), :order => "created_at DESC"
  end
  
end