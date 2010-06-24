require 'rails/generators'
require 'rails/generators/migration'

module Freeberry
  class ModelsGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    
    class_option :migrations, :type => :boolean, :default => true, :description => "Generate migrations files"

    desc "Generates migrations and models"
     
    def self.source_root
      @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
    end

    def self.current_time
      @current_time ||= Time.now
      @current_time += 1.minute
    end

    def self.next_migration_number(dirname)
      current_time.strftime("%Y%m%d%H%M%S")
    end
    
    def create_models
      directory "models", "app/models/defaults"
    end
    
    def create_migrations
      if options.migrations
        [:users, :roles, :structures, :posts, :pages, :assets, :comments, :headers].each do |item|
          migration_template "create_#{item}.rb", File.join('db/migrate', "freeberry_create_#{item}.rb")
        end
      end
    end
  end
end
