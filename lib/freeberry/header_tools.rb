# encoding: utf-8
module Freeberry
  module HeaderTools
    def self.included(base)
      base.send(:extend, ClassMethods)
      base.send(:include, InstanceMethods)
    end
    
    module ClassMethods
      def self.extended(base)
        base.class_eval do
          has_one :header, :as => :headerable, :dependent => :delete
          accepts_nested_attributes_for :header, :reject_if => :all_blank
        end
      end
    end
    
    module InstanceMethods
    end
  end
end
