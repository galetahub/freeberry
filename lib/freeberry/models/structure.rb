# encoding: utf-8
module Freeberry
  module Structure
    def self.included(base)
      base.send :include, InstanceMethods
      base.send :extend,  ClassMethods
    end
    
    module ClassMethods
      def self.extended(base)
        base.send(:include, HeaderTools)
        base.class_eval do
          acts_as_nested_set
          
          enumerated_attribute :structure_type, :id_attribute => :kind
          enumerated_attribute :position_type, :id_attribute => :position
          
          validates_presence_of :title
          validates_numericality_of :position, :only_integer => true
          
          has_slug :prepend_id => false
          
          has_one :page, :dependent => :destroy
          has_many :posts, :dependent => :destroy
          
          scope :visible, where(:is_visible => true)
          scope :with_kind, proc {|structure_type| where(:kind => structure_type.id) }
          scope :with_depth, proc {|level| where(:depth => level.to_i) }
          scope :with_position, proc {|position_type| where(:position => position_type.id) }
        end
      end
    end
    
    module InstanceMethods
      def moveable?
        return true if new_record?
        !root?
      end
    end
  end
end
