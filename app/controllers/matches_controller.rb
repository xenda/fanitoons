class MatchesController < ApplicationController

  before_filter :authenticate_account!, :except =>[:index,:show]


  def index
    @matches = Match.all(:order => "played_at DESC", :limit => 40)
  end

  def show
    @match = Match.find(params[:id])
  end

  def prediction
        
    @match = Match.find(params[:id])
    
    if current_account.has_predicted_match?(@match)
      redirect_to edit_match_prediction_path @match,current_account.prediction_for_match(@match).first
    else
      redirect_to new_match_prediction_path @match
    end
    
  end
    
end