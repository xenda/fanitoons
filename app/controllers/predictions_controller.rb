class PredictionsController < ApplicationController
    
  def new
    @prediction = current_account.predictions.build
    @prediction.match_id = params[:match_id]
    @prediction.to_facebook = true
  end

  def post_facebook
    @prediction = Prediction.find(params[:id])
    
    logger.info "Back from FB"
    access_token = facebook_authorization(redirect_uri)
    
    logger.info "Got token: #{access_token}"
    client = reauthenticate(access_token)
    
    logger.info "Updated client"
    
    status = current_account.authenticate_from_facebook(client.selection.me.info!,access_token)
    
    logger.info "Updated account"
    
    flash[:notice] = "Enlazada tu sesión con Facebook "
    post_to_wall("¡He pronosticado en Patatoon! Creo que #{@prediction.try(:winner).try(:name)} gana en el partido de #{@prediction.match.local.name} vs #{@prediction.match.try(:visitor).try(:name)}","Ganador: #{@prediction.try(:winner).try(:name)}","#{current_account.full_name} ha dejado su pronóstico en Patatoon y ha ganado puntos por eso. ¿No te animas?","http://patatoon.heroku.com#{match_path(@prediction.match)}")
    redirect_to edit_match_prediction_path(@prediction.match,@prediction)
    
  end
  
  def redirect_uri
    post_facebook_url(@prediction.id)
  end
    
  def create
    @prediction = Prediction.new(params[:prediction])
    if @prediction.save
      flash[:prediction_notice] = '¡Muy bien tigre.! Veamos si resulta así.'
      
      if @prediction.to_facebook
        
        
        if current_account.no_token?
          redirect_to(facebook_authentication(redirect_uri)) 
        else
          post_to_wall("¡He pronosticado en Patatoon! Creo que #{@prediction.try(:winner).try(:name)} gana en el partido de #{@prediction.match.local.name} vs #{@prediction.match.try(:visitor).try(:name)}","Ganador: #{@prediction.try(:winner).try(:name)}","#{current_account.full_name} ha dejado su pronóstico en Patatoon y ha ganado puntos por eso. ¿No te animas?","http://patatoon.heroku.com#{match_path(@prediction.match)}")

        end
        
      else
        redirect_to edit_match_prediction_path(@prediction.match,@prediction)    
      end      
  
  
    else
      render 'predictions/new'
    end
  end

  def edit
    @prediction = Prediction.find(params[:id])
    @prediction.to_facebook ||= true
  end

  def update
    @prediction = Prediction.find(params[:id])
    if @prediction.update_attributes(params[:prediction])
      flash[:prediction_notice] = 'Listo campeón. Hemos actualizado tu predicción.'
      logger.info "Token: #{current_account.fb_token}"
      logger.info "Token? #{current_account.no_token?}"

      if @prediction.to_facebook
        
        
        if current_account.no_token?
          redirect_to(facebook_authentication(redirect_uri)) 
        else
          post_to_wall("¡He pronosticado en Patatoon! Creo que #{@prediction.try(:winner).try(:name)} gana en el partido de #{@prediction.match.local.name} vs #{@prediction.match.try(:visitor).try(:name)}","Ganador: #{@prediction.try(:winner).try(:name)}","#{current_account.full_name} ha dejado su pronóstico en Patatoon y ha ganado puntos por eso. ¿No te animas?","http://patatoon.heroku.com#{match_path(@prediction.match)}")

        end
        
      else
        redirect_to edit_match_prediction_path(@prediction.match,@prediction)    
      end      


    else
      render 'predictions/edit'
    end
  end

end