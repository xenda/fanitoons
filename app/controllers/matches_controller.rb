class MatchesController < ApplicationController

  def index
    @matches = Match.all(:order => "played_at DESC", :limit => 40)
  end

  def show
    @match = Match.find_by_id(params[:id])
  end

  def prediction
    @match = Match.find_by_id(params[:id])
    
    if current_account.has_predicted_match?(@match)
      redirect_to edit_match_prediction_path [@match,current_account.prediction_for_match(@match).first.id]
    else
      redirect_to new_match_prediction_path @match
    end
    
  end
  
end