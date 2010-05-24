ActionController::Routing::Routes.draw do |map|

  map.devise_for :admins

  map.devise_for :accounts, :as => "cuentas", :path_names => { :sign_in => 'entrar', :sign_out => 'salir', :registration => 'registro'}
  map.new_account_session 'entrar', :controller => 'sessions', :action => 'new', :conditions => { :method => :get }
  map.account_session 'entrar', :controller => 'sessions', :action => 'create', :conditions => { :method => :post }
  map.destroy_account_session 'salir', :controller => 'sessions', :action => 'destroy', :conditions => { :method => :get }
  
  
  map.resources :matches, :as =>"encuentros" do |matches|
    matches.resources :predictions, :as => "pronosticos"
  end
  
  map.resources :predictions, :as => "pronosticos"
  map.resources :players, :as => "jugadores"
  map.resources :posts, :as => "entradas"
  map.resources :stadia, :as => "estadios"
  map.resources :teams, :as => "equipos"
  # map.resources :accounts, :as=>"cuentas"
  
  map.match_prediction "/encuentros/:id/pronostico", :controller=>"matches", :action=>"prediction"
    
  map.root :controller=>"home", :action=>"index"
  map.fb_connect "/fbconnect", :controller=>"sessions", :action=>"fb_connect"
  map.fb_connect_callback "/fbconnect/callback", :controller=>"sessions", :action=>"fb_connect_callback"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
