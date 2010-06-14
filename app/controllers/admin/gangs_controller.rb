class Admin::GangsController < InheritedResources::Base

  layout "admin"
  before_filter :authenticate_admin!
  
  def create
    create! { admin_gangs_path }
  end
  
  def update
    update! { admin_gangs_path }
  end
  
  def collection
    @gangs ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 10)
  end
  
  def activate
    @gang = Gang.find(params[:id])
    @gang.activate!
    respond_to do |wants|
      if @gang.activate!
        wants.html do
          render :text => "<span>Grupo #{@gang.full_name} activado</span>"
        end
      end
    end
  end

end