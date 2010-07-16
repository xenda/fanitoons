module Admin::AdminHelper
  
  def app_models
    models = [] 
    Dir.glob( RAILS_ROOT + '/app/models/*' ).each do |f| 
      models << File.basename( f ).gsub( /^(.+).rb/, '\1') 
    end 
    models.reject{|m| ["favorite_team","friendship", "friend","user_badge","admin","","gang_mailer","message","membership","message_mailer","folder","championship_team",""].include? m }
  end
  
    
  def display_app_models_links
    ul_tag(app_models)
  end
  
  def ul_tag(items,options={})
    
    items_list = items.map{|item| content_tag(:li,link_to(t("activerecord.models.#{item.downcase}").pluralize,url_for(:controller=>"admin/#{item.downcase.pluralize}",:action=>"index")))}.join
    
    content_tag(:ul,items_list,options)
  end
  
  def summary(text)
    truncate(strip_tags(text),50)
  end
  
  def date(date_string)
    l(date_string,:format=>:short)
  end
  
  def image(picture)
    image_tag(picture.url(:thumbnail)) if picture
  end
  
end