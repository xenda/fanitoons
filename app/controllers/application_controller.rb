# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def client
    if current_account && current_account.fb_token
      FBGraph::Client.new(:client_id => $api_key,:secret_id =>$secret_key,:token=>current_account.fb_token) 
    else
      FBGraph::Client.new(:client_id => $api_key,:secret_id =>$secret_key) 
    end

       # OAuth2::Client.new($api_key, $secret_key, :site => 'https://graph.facebook.com')
  end

  def facebook_authentication(redirect = nil)
    redirect_url = redirect || redirect_uri
    client.authorization.authorize_url(:redirect_uri => redirect_url , 
                                       :scope =>   'email,offline_access,publish_stream')
  end

  def facebook_authorization(redirect = nil)
    redirect_url = redirect || redirect_uri
    client.authorization.process_callback(params[:code], :redirect_uri =>  redirect_url) 
  end

  def reauthenticate(access_token)
    client = FBGraph::Client.new(:client_id => $api_key,:secret_id =>$secret_key,:token=>access_token) 
  end

  def redirect_uri
    fb_connect_callback_url
  end
  
  def post_to_wall(message,name,description,link,image="http://patatoon.heroku.com/images/patatoon.png")
    client.selection.user(current_account.fb_id).feed.publish!(:message => message , :name =>name,:link=>link,:description=>description, :picture => image)
    redirect_to edit_match_prediction_path(@prediction.match,@prediction)
  end
  
end
