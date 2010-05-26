class PredictionsController < ApplicationController
    
  def new
    @prediction = current_account.predictions.build
    @prediction.match_id = params[:match_id]
  end

  def create
    @prediction = Prediction.new(params[:prediction])
    if @prediction.save
      flash[:prediction_notice] = '¡Muy bien tigre.! Veamos si resulta así.'
       # client = reauthenticate(current_account.fb_token)
       client.selection.user(current_account.fb_id).feed.publish!(:message => "¡He pronosticado en Patatoon! Creo que #{@prediction.try(:winner).try(:name)} gana en el partido de #{@prediction.match.local.name} vs #{@prediction.match.try(:visitor).try(:name)} " , :name =>"Ganador: #{@prediction.try(:winner).try(:name)}",:link=>"http://patatoon.heroku.com#{match_path(@prediction.match)}",:description=>"#{current_account.full_name} ha dejado su pronóstico en Patatoon y ha ganado puntos por eso. ¿No te animas?", :picture => "http://patatoon.heroku.com/images/patatoon.png") if current_account.from_facebook?
       
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
      flash[:prediction_notice] = 'Listo campeón. Hemos actualizado tu predicción.'
      # client = reauthenticate(current_account.fb_token)
      client.selection.user(current_account.fb_id).feed.publish!(:message => "¡He pronosticado en Patatoon! Creo que #{@prediction.try(:winner).try(:name)} gana en el partido de #{@prediction.match.local.name} vs #{@prediction.match.try(:visitor).try(:name)} " , :name =>"Ganador: #{@prediction.try(:winner).try(:name)}",:link=>"http://patatoon.heroku.com#{match_path(@prediction.match)}",:description=>"#{current_account.full_name} ha dejado su pronóstico en Patatoon y ha ganado puntos por eso. ¿No te animas?", :picture => "http://patatoon.heroku.com/images/patatoon.png") if current_account.from_facebook?
       redirect_to edit_match_prediction_path(@prediction.match,@prediction)
    else
      render 'predictions/edit'
    end
  end

end