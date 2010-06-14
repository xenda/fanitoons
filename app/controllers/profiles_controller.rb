class ProfilesController < ApplicationController
  
  def show
    @profile = Profile.active.find(params[:id])
    @account = @profile.account
  end
  
  def index
    @order = params[:order] || 'created_at'
    @page = params[:page] || '1'
    @asc = params[:asc] || 'desc'   
    @profiles = Profile.active.paginate :per_page => 10,
                                 :page => @page,
                                 :order => "profiles.#{@order} #{@asc}"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @profiles }
    end
  end
  
end


