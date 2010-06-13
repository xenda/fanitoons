# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

raise "No se hallaron claves de autenticacíón para Facebook" unless File.exist?(api_keys_file = "api_keys.yml")
$keys = YAML.load(File.read(api_keys_file))
$api_key, $secret_key = $keys['api_key'], $keys['secret_key']



require 'desert'

require 'desert'
Rails::Initializer.run do |config|
  config.reload_plugins = true if RAILS_ENV == 'development'

  config.reload_plugins = true if RAILS_ENV == 'development'
  config.gem 'oauth', :version => '>= 0.3.5'
  config.gem 'rubyist-aasm', :lib => 'aasm', :version => '~> 2.1.1'
  config.gem 'linkingpaths-acts_as_abusable', :lib => 'acts_as_abusable', :version => '0.0.2'
  config.gem 'mbleigh-acts-as-taggable-on', :lib => 'acts-as-taggable-on', :version => '1.0.5'
  config.gem 'RedCloth', :lib => 'redcloth', :version => '>= 4.2.0'
  config.gem 'mreinsch-acts_as_rateable', :lib => 'acts_as_rateable', :version => '2.0.1'
  config.gem 'jackdempsey-acts_as_commentable', :lib => 'acts_as_commentable', :version => '2.0.1'
  config.gem 'thoughtbot-factory_girl', :lib => 'factory_girl'
  config.gem 'tog-tog', :lib => 'tog', :version => '>= 0.5'
  config.gem 'mislav-will_paginate', :lib => 'will_paginate', :version => '~> 2.3.6'
  config.gem 'desert', :lib => 'desert', :version => '>= 0.5.2'
  # config.gem 'oauth', :version => '>= 0.3.5'
  # config.gem 'rubyist-aasm', :lib => 'aasm', :version => '~> 2.1.1'
  # config.gem 'linkingpaths-acts_as_abusable', :lib => 'acts_as_abusable', :version => '0.0.2'
  # config.gem 'mbleigh-acts-as-taggable-on', :lib => 'acts-as-taggable-on', :version => '1.0.5'
  # config.gem 'RedCloth', :lib => 'redcloth', :version => '>= 4.2.0'
  # config.gem 'mreinsch-acts_as_rateable', :lib => 'acts_as_rateable', :version => '2.0.1'
  # config.gem 'jackdempsey-acts_as_commentable', :lib => 'acts_as_commentable', :version => '2.0.1'
  # config.gem 'thoughtbot-factory_girl', :lib => 'factory_girl'
  # config.gem 'tog-tog', :lib => 'tog', :version => '>= 0.5'
  # config.gem 'mislav-will_paginate', :lib => 'will_paginate', :version => '~> 2.3.6'
  # config.gem 'desert', :lib => 'desert', :version => '>= 0.5.2'
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.a
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]
  config.gem 'nokogiri'
  config.gem 'faker'
  config.gem 'paperclip'
  config.gem 'facebooker'
  config.gem 'oauth2'
  config.gem 'json'
  config.gem "aws-s3", :lib => "aws/s3"
  config.gem 'fbgraph'
  config.gem 'haml'
  config.gem 'warden'
  config.gem "devise", :version=>"1.0.7"
  config.gem "bcrypt-ruby", :lib=>"bcrypt", :version=>"2.1.2"
  config.gem 'devise_invitable', :version=>"0.2.3"
  config.gem 'inherited_resources', :version=>"1.0.3"
  config.gem 'has_scope'
  config.gem 'formtastic'
  config.gem 'show_for', :version=>"0.1.3"
  config.gem 'mislav-will_paginate',
             :lib => 'will_paginate',
             :source => 'http://gems.github.com',
             :version => '~> 2.3.11'
  config.gem 'bullet', :source => 'http://gemcutter.org'             
  # config.gem 'sqlite3-ruby', :require => "sqlite3"
  
  
  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'Lima'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  config.i18n.default_locale = :es
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true
  
end




  # ActionMailer::Base.smtp_settings = {
  #    :address => "smtp.gmail.com",
  #    :enable_starttls_auto => true,  
  #    :port => 587,
  #    :domain => "skykidsperu.com",
  #    :authentication => :plain,
  #    :user_name => "control@skykidsperu.com",
  #    :password => "control"
  #  }


