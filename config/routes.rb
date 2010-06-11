ActionController::Routing::Routes.draw do |map|
  
	map.namespace :admin do |admin| 
		admin.resources :places 
	end


  
	map.namespace :admin do |admin| 
		admin.resources :post_images 
	end

  map.avatar "/avatar", :controller=>"home", :action=>"index"
    
  map.resources :user_badges
  map.resources :badges
  map.resources :friendships
  map.resources :favorite_teams
  map.resources :friends
  map.resources :post_images

  # map.new_account_session 'entrar', :controller => 'sessions', :action => 'new', :conditions => { :method => :get }
  #   map.account_session 'entrar', :controller => 'sessions', :action => 'create', :conditions => { :method => :post }
  #   map.destroy_account_session 'salir', :controller => 'sessions', :action => 'destroy', :conditions => { :method => :get }
  
  map.devise_for :accounts, :as => "cuentas", :path_names => { :sign_in => 'entrar', :sign_out => 'salir', :registration => 'registro'}

  map.devise_for :admins
  
  map.namespace :admin do |admin|
    admin.resources :matches, :as=>"encuentros"
    admin.resources :accounts, :as=>"cuentas"
    admin.resources :friends, :as=>"amigos"
    admin.resources :players, :as=>"jugadores"
    admin.resources :posts, :as => "entradas"
    admin.resources :predictions, :as=>"pronosticos"
    admin.resources :stadia, :as=>"estadios"
    admin.resources :teams, :as=>"equipos"
    admin.resources :snickers, :as=>"zapatillas"
		admin.resources :shorts, :as => "pantalones"
		admin.resources :shirts , :as => "camisetas"
		admin.resources :groups, :as => "grupos"
		admin.resources :countries, :as => "paises"
		admin.resources :comments, :as => "comentarios" 
		admin.resources :badges, :as => "medallas" 
		admin.resources :avatars, :as => "avatares" 
		
  end
  
  map.resources :matches, :as =>"encuentros" do |matches|
    matches.resources :predictions, :as => "pronosticos"
  end
  
  map.resources :predictions, :as => "pronosticos"
  map.player_predictions "/cuentas/:account_id/predicciones/", :controller=>"predictions", :action=>"index"
  map.resources :players, :as => "jugadores"
  map.resources :posts, :as => "entradas"
  map.resources :stadia, :as => "estadios"
  map.resources :teams, :as => "equipos"
  
  # map.resources :accounts, :as=>"cuentas"
  map.invite_friends "/invitar", :controller => "home", :action=>"invite"
  map.match_prediction "/encuentros/:id/pronostico", :controller=>"matches", :action=>"prediction"
  map.post_facebook "/facebook/prediccion/:id/mensaje", :controller=>"predictions", :action=>"post_facebook"
  map.root :controller=>"home", :action=>"index"
  map.fb_connect "/facebook", :controller=>"facebook", :action=>"fb_connect"
  map.fb_connect_callback "/facebook/retorno", :controller=>"facebook", :action=>"fb_connect_callback"
  map.fb_invite_frients "/facebook/invitacion", :controller=>"facebook", :action=>"fb_invite_friends"
  map.profile "/perfil/:id", :controller=>"profiles", :action=>"show"
  map.admin_dashboard "/admin", :controller=>"admin/posts", :action=>"index"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
