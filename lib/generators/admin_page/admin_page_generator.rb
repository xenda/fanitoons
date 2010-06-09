class AdminPageGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      
      admin_view_folder = "app/views/admin/#{plural_name}"
      admin_controller_folder = "app/controllers/admin"
      admin_helper_folder = "app/helpers/admin"
      
      # Controllers
      m.directory admin_controller_folder
      m.template "controllers/resource_controller.rb", "#{admin_controller_folder}/#{plural_name}_controller.rb", :assigns=>{:plural_name => plural_name, :class_name=>class_name, :plural_class_name => plural_class_name }
      
      # Helpers
      m.directory admin_helper_folder
      m.file "helpers/admin_helper.rb", "app/helpers/admin/admin_helper.rb"

      base_column_names = class_name.constantize.column_names
      
      # We reject created_at and updated_at columns
      column_names = base_column_names.map(&:dup).reject{|column| ["created_at","updated_at"].include? column }
      
      # We change the _id elements with association name
      column_names = column_names.map do |c| 
                        c.gsub! "_id","" if c.include? "_id"
                        c 
                      end
      # Views
      m.directory admin_view_folder
      m.template "views/layouts/admin.html.haml", "app/views/layouts/admin.html.haml"
      m.template "views/resource/index.html.haml", "#{admin_view_folder}/index.html.haml", :assigns =>{:plural_class_name => plural_class_name, :plural_name => plural_name, :singular_name => singular_name, :column_names =>base_column_names}
      
      
      m.template "views/resource/new.html.haml", "#{admin_view_folder}/new.html.haml", :assigns => { :singular_name => singular_name, :plural_name => plural_name }
      m.template "views/resource/edit.html.haml", "#{admin_view_folder}/edit.html.haml", :assigns => {:singular_name => singular_name, :plural_name => plural_name, :column_names => column_names }
      m.template "views/resource/show.html.haml", "#{admin_view_folder}/show.html.haml", :assigns => {:singular_name => singular_name, :plural_name => plural_name, :column_names => column_names}
      m.template "views/resource/_form.html.haml", "#{admin_view_folder}/_form.html.haml", :assigns =>{:column_names => column_names, :singular_name => singular_name }

      # CSS, images and javascript files
      m.file "assets/admin_style.css", "public/stylesheets/admin_style.css"
      m.file "assets/admin_application.js", "public/javascripts/admin_application.js"

      m.readme "INSTALL"
      
      
      m.route :resource => plural_name
      
    end
  end

  private

  def singular_name
    file_name.underscore
  end

  def plural_name
    file_name.underscore.pluralize
  end

  def class_name
    file_name.camelize
  end

  def plural_class_name
    plural_name.camelize
  end



end

module Rails
  module Generator
    module Commands

      class Base
        def route_code(route_options)
          "map.#{route_options[:name]} '#{route_options[:name]}', :controller => '#{route_options[:controller]}', :action => '#{route_options[:action]}'"
        end
        
        def admin_route_code(route_options)
          "\n\tmap.namespace :admin do |admin| \n\t\tadmin.resources :#{route_options[:resource]} \n\tend\n"
        end
      
        def app_models
          Module.constants.select do |constant_name|
            constant = eval constant_name
            if not constant.nil? and constant.is_a? Class and constant.superclass == ActiveRecord::Base
              constant
            end
          end    
        end        
        
      end

# Here's a readable version of the long string used above in route_code;
# but it should be kept on one line to avoid inserting extra whitespace
# into routes.rb when the generator is run:
# "map.#{route_options[:name]} '#{route_options[:name]}',
#     :controller => '#{route_options[:controller]}',
#     :action => '#{route_options[:action]}'"

      class Create
        def route(route_options)
          sentinel = 'ActionController::Routing::Routes.draw do |map|'
          logger.route admin_route_code(route_options)
          gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |m|
              "#{m}\n  #{admin_route_code(route_options)}\n"
          end
        end

      end

      class Destroy
        def route(route_options)
          logger.remove_route admin_route_code(route_options)
          to_remove = "\n  #{admin_route_code(route_options)}"
          gsub_file 'config/routes.rb', /(#{to_remove})/mi, ''
        end
      end

    end
  end
end
