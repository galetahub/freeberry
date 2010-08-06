# encoding: utf-8
module Freeberry
  module Models
    module Header
      def self.included(base)
        base.send :include, InstanceMethods
        base.send :extend,  ClassMethods
      end
      
      module ClassMethods
        def self.extended(base)
          base.class_eval do
            validates_presence_of :headerable_type, :headerable_id
    
            belongs_to :headerable, :polymorphic => true
          end
        end
      end
      
      module InstanceMethods
      end
    end
  end
end
