ActionController::Routing::Routes.draw do |map|
  map.resources :titles


  map.connect "/upload", :controller => "home", :action=>"upload"
  map.connect "/posts/", :controller => "home", :action => "post"
  map.connect "/carga/", :controller => "home", :action => "post"
  # map.routes_from_plugin 'tog_mail'
  # 
  # map.routes_from_plugin 'tog_social'
  # 
  # map.routes_from_plugin 'tog_core'


  map.namespace(:member) do |member|

    member.with_options(:controller => 'messages') do |messages|
    
      messages.resources :messages,
        :collection => { :move => :post,
                         :copy => :post,
                         :mark_as_read => :post,
                         :mark_as_unread => :post,
                         :search => :get
                       },
        :member => { :reply => :get }
      messages.new_message_to 'mensajes/nuevo/:account_id', :action => "new"
    end

  end

  map.with_options(:controller => 'abuse') do |abuse|
    abuse.report_abuse    'reportar_abuso', :action => 'new',    :conditions => { :method => :get }
    abuse.report_abuse_with_model 'reportar_abuso/:resource_type/:resource_id',    :action => 'new',    :conditions => { :method => :get }
    abuse.report_abuse_create     'reportar_abuso',    :action => 'create', :conditions => { :method => :post }
  end


  map.resources :streams, :only => [:index, :show], :member => {:network => :get}

  map.with_options(:controller => 'gangs') do |group|
    group.tag_groups       '/gangs/tag/:tag',                         :action => 'tag'
  end

  map.resources :gangs, :collection => { :search => :get }, :member => { :join => :get, :leave => :get, :accept_invitation => :get, :reject_invitation => :get }

  map.resources :profiles

  map.namespace(:member) do |member|
    member.resources :profiles, :as => "perfiles"
    member.resources :gangs
    member.with_options(:controller => 'gangs') do |group|
      group.group_pending_members '/:id/miembros/pendiente',         :action => 'pending_members'
      group.group_accept_member   '/:id/miembros/:account_id/aceptar', :action => 'accept_member'
      group.group_reject_member   '/:id/miembros/:account_id/rechazar', :action => 'reject_member'
      group.group_invite          '/mancha/invitar',                :action => 'invite'
    end
    member.with_options(:controller => 'friendships') do |friendship|
      friendship.add_friend     '/amigos/:friend_id/agregar',     :action => 'add_friend'
      friendship.confirm_friend '/amigos/:friend_id/confirmar', :action => 'confirm_friend'
      friendship.follow_user    '/seguir/:friend_id',         :action => 'follow'
      friendship.unfollow_user  '/ignorar/:friend_id',       :action => 'unfollow'
    end
    member.with_options(:controller => 'sharings') do |sharing|
      sharing.share '/sharings/share/:gang_id/:shareable_type/:shareable_id', :action => 'create', :conditions => { :method => :post }    
      sharing.new_sharing '/sharings/:shareable_type/:shareable_id/new', :action => 'new'
      sharing.sharings '/sharings', :action => 'index'
      sharing.destroy_sharing '/sharings/:gang_id/:id', :action => 'destroy', :conditions => { :method => :delete }      
  #    sharing.destroy_sharing '/group/:id/remove/:shareable_type/:shareable_id', :action => 'destroy', :method => :delete  
    end
  end


  
	map.namespace :admin do |admin| 
		admin.resources :places 
	end

  
	map.namespace :admin do |admin| 
		admin.resources :post_images 
	end

  map.avatar "/avatar", :controller=>"avatar", :action=>"index"
    
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
    matches.resources :comments, :as => "comentarios"
  end
  
  map.resources :predictions, :as => "pronosticos", :has_many => :comments
  map.player_predictions "/cuentas/:account_id/predicciones/", :controller=>"predictions", :action=>"index"
  map.resources :players, :as => "jugadores"
  map.resources :posts, :as => "entradas", :has_many => :comments
  map.resources :stadia, :as => "estadios"
  map.resources :teams, :as => "equipos", :has_many => :comments
  
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
