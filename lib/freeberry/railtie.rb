# encoding: utf-8
require 'rails'
require 'freeberry'

module Freeberry
  class Engine < ::Rails::Engine   
    config.before_initialize do
      ActiveSupport::XmlMini.backend = 'Nokogiri'
      
      Responders::FlashResponder.flash_keys = [ :success, :failure ]
      InheritedResources.flash_keys = [ :success, :failure ]
        
      config.i18n.load_path += Dir[File.join(File.dirname(__FILE__), "../../config", 'locales', '**', '*.{rb,yml}').to_s]
      
      I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)
      
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.send :include, Freeberry::MysqlUtils
        ActiveRecord::Base.send :include, Freeberry::AccessibleAttributes
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
