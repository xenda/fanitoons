class TeamsController < ApplicationController

  def index
    @teams = Team.all(:order => 'created_at desc')    
  end
  
  def show
    @team = Team.find_by_id(params[:id])    
  end

end