# encoding: utf-8
module Freeberry
  module HeaderTools
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def self.extended(base)
        base.has_one :header, :as=>:headerable, :dependent=>:destroy
        base.after_update :save_header
      
        base.send :include, InstanceMethods
      end
    end
    
    module InstanceMethods
      def page_header=(value)
        h = self.header || self.build_header
        h.attributes = value
      end
    
      private
      
        def save_header
          self.header.save(:validate => false) unless self.header.nil?
        end
    end
  end
end
