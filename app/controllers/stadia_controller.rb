class StadiaController < ApplicationController
  
  def index
    @stadia = Stadium.all(:order => 'created_at desc')
  end
  
  def show
    @stadium = Stadium.find_by_id(params[:id])    
  end

end