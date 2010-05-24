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

  def facebook_authentication
    client.authorization.authorize_url(:redirect_uri => redirect_uri , 
                                       :scope =>   'email,offline_access,publish_stream')
  end

  def facebook_authorization
    client.authorization.process_callback(params[:code], :redirect_uri =>  redirect_uri) 
  end

  def reauthenticate(access_token)
    client = FBGraph::Client.new(:client_id => $api_key,:secret_id =>$secret_key,:token=>access_token) 
  end

  def redirect_uri
    fb_connect_callback_url
  end
  
end
