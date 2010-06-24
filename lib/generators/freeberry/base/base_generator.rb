require 'rails/generators'

module Freeberry
  class BaseGenerator < Rails::Generators::Base

    def self.source_root
      @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
    end  
    
    # copy images
    def copy_images
      directory "images/manage", "public/images/manage"
    end
    
    # copy javascripts
    def copy_javascripts
      directory "javascripts", "public/javascripts"
    end
    
    # copy stylesheets
    def copy_stylesheets
      directory "stylesheets", "public/stylesheets"
    end
    
    # copy views
    def copy_views
      directory "views", "app/views"
    end
    
    # copy sweepers
    def copy_sweepers
      directory "sweepers", "app/sweepers"
    end
    
    def copy_configurations
      copy_file('config/words', 'config/words')
      copy_file('config/authorization_rules.rb', 'config/authorization_rules.rb')
      copy_file('config/seeds.rb', 'db/seeds.rb')
      copy_file('config/freeberry.rb', 'config/initializers/freeberry.rb')
      
      template('config/application.yml', 'config/application.yml.sample')
      template('config/database.yml', 'config/database.yml.sample')
      template('config/logrotate-config', 'config/logrotate-config.sample')
      template('config/nginx-config-passenger', 'config/nginx-config-passenger.sample')
    end
    
    def copy_helpers
      directory('helpers', 'app/helpers')
    end
    
    protected
      
      def app_name
        @app_name ||= File.basename(Rails.root)
        @app_name
      end
      
      def app_path
        @app_path ||= Rails.root.to_s
        @app_path
      end
  end
end
