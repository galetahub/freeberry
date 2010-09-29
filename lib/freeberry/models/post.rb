# encoding: utf-8
module Freeberry
  module Models
    module Post
      def self.included(base)
        base.send :include, InstanceMethods
        base.send :extend,  ClassMethods
      end
      
      module ClassMethods
        def self.extended(base)
          base.send(:include, HeaderTools)
          base.class_eval do
            belongs_to :structure
            has_many :comments, :as => :commentable, :dependent => :delete_all
            has_slug
            
            validates_presence_of :title, :content
	
	          before_save :make_date
          end
        end
      end
      
      module InstanceMethods
      
        def content_without_html
          return nil if self.content.blank?
          self.content.no_html
        end
        
        protected
    
          def make_date
            self.published_at ||= Time.now
      
            self.year  = self.published_at.year  if respond_to?(:year)
            self.month = self.published_at.month if respond_to?(:month)
            self.day   = self.published_at.day   if respond_to?(:day)
          end
      end
    end
  end
end
