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
    
    if @prediction.undoable?
    flash[:prediction_notice] = 'Lo siento tigre, sólo puedes pronosticar hasta 5 horas antes del partido.'
    render 'predictions/new'
    
    else
    
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
  end

  def edit
    @prediction = Prediction.find(params[:id])
    @prediction.to_facebook ||= true
  end


  def index
    
    if params[:account_id]
      @predictions = Account.find(params[:account_id]).predictions.paginate(:all, :include => [:winner, {:match=>[:local,:visitor]}], :page => params[:page])
    else
      @predictions = Prediction.last(6).find(:all, :include => [:winner, {:match=>[:local,:visitor]}])
      
    end
    
    
    @popular_predictions = Match.most_popular(8).find(:all, :include => [:local, :visitor])
    @most_commented = Prediction.most_commented(4).find(:all, :include => {:match =>[:local, :visitor]})
    @matches = Match.all(:order=> "played_at", :limit=>7, :include => [:local, :visitor], :conditions => ["played_at >= ?",Time.zone.now])
    
    if params[:account_id]
      render :action => "user_predictions", :layout => "application"
    else
      render :action => "index", :layout=> "application"
    end
  end
  
  def show
    @prediction = Prediction.find(params[:id])
    render :action => "show", :layout => "application"
  end

  def update
    @prediction = Prediction.find(params[:id])
    
    if @prediction.undoable?
    flash[:prediction_notice] = 'Lo siento tigre, sólo puedes pronosticar hasta 5 horas antes del partido.'
    
    render 'predictions/edit'
    
    else
    
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

end