# encoding: utf-8
require 'freeberry'

module Freeberry
  if defined? Rails::Railtie
    require 'rails'
    class Railtie < Rails::Railtie      
      config.before_initialize do
        ActiveSupport::XmlMini.backend = 'Nokogiri'
        I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)
          
        config.i18n.load_path += Dir[File.join(File.dirname(__FILE__), "../../config", 'locales', 'defaults', '*.{rb,yml}').to_s]
        config.i18n.load_path += Dir[File.join(File.dirname(__FILE__), "../../config", 'locales', 'manage', '*.{rb,yml}').to_s]
        
        ActiveSupport.on_load :active_record do
          ActiveRecord::Base.send :include, Freeberry::MysqlUtils
        end
      end
      
      config.after_initialize do
        ActionController::Base.send :include, Freeberry::Controllers::AuthorizedSystem
        ActionController::Base.send :include, Freeberry::Controllers::HeadOptions
      
        ActionView::Base.send :include, Freeberry::Controllers::HelperTools
      end
      
      rake_tasks do
        load "tasks/freeberry.rake"
      end
    end
  end
end
