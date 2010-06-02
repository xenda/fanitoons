class FacebookController < ApplicationController

  before_filter :authenticate_account!, :only =>[:fb_invite_friends]
 

  def fb_connect
       
      redirect_to facebook_authentication  
      
  end
  
  def fb_connect_callback
    
    access_token = facebook_authorization
    
    client = reauthenticate(access_token)
    
    status,account = Account.authenticate_from_facebook(client.selection.me.info!,access_token)
        
    case status
      
      when Account::EXISTING_ACCOUNT
        flash[:notice] = "Iniciando tu sesión gracias a Facebook"
        # set_current_account(account)
        sign_in(account)
        redirect_to root_path
      when Account::NEW_ACCOUNT
        flash[:notice] = "Tu cuenta ha sido creada gracias a Facebook. ¡Bienvenido!"
        sign_in(account)
        # client.selection.user(account.fb_id).feed.publish!(:message => "¡Acabo de registrarme en PataToon! ¿No te animas?" , :name => 'Otro feliz miembro más :)',:link=>"http://fanitoons.heroku.com",:description=>"Descripción", :picture => "http://pagina.jccm.es/edu/ies/ojosguadiana/futbol.gif")
        
        
        # set_current_account(account)
        redirect_to root_path
      when Account::WRONG_ACCOUNT
        flash[:notice] = "Hubieron problemas accediendo a tus datos de Facebook. Prueba de nuevo o <a href='#{new_account_registration_path}'>créala directamente acá</a>"
        redirect_to root_path # TODO: url(:accounts,:new)
          
    end
            
  end
  
  def fb_invite_friends
    facebook_authentication
    client = reauthenticate(current_account.fb_token)
    @friends = client.selection.me.friends.info!
    # @friends[:data].each do |friend|
    #   
    # end
    
    
    render :text => @friends.to_json
  end
  
  def destroy
    sign_out(current_account) if current_account
    flash[:notice] = "Has cerrado sesión"
    redirect_to root_path
  end


end