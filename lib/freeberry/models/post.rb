# encoding: utf-8
module Freeberry
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
	
	        scope :visible, where(:is_visible => true)
        end
      end
    end
    
    module InstanceMethods
    
      def content_without_html
        return nil if self.content.blank?
        self.content.no_html
      end
      
      private
  
        def make_date
          self.created_at ||= Time.now
          self.year = self.created_at.year
        end
    end
  end
end
