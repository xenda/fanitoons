class PredictionsController < ApplicationController
  
  def new
    @prediction = current_account.predictions.build
    @prediction.match_id = params[:match_id]
  end

  def create
    @prediction = Prediction.new(params[:prediction])
    if @prediction.save
      flash[:notice] = 'Prediction was successfully created.'
      redirect_to edit_match_prediction_path(@prediction.match,@prediction)
    else
      render 'predictions/new'
    end
  end

  def edit
    @prediction = Prediction.find(params[:id])
  end

  def update
    @prediction = Prediction.find(params[:id])
    if @prediction.update_attributes(params[:prediction])
      flash[:notice] = 'Prediction was successfully updated.'
      redirect_to edit_match_prediction_path [@prediction.match,@prediction]
    else
      render 'predictions/edit'
    end
  end

end