# encoding: utf-8
module Freeberry
  module Models
    module Comment
      def self.included(base)
        base.send :include, InstanceMethods
        base.send :extend,  ClassMethods
      end
      
      module ClassMethods
        def self.extended(base)
          base.class_eval do
            belongs_to :commentable, :polymorphic => true, :counter_cache => :comments_count
            belongs_to :author, :polymorphic => true
            
            validates :user_name, :presence => true, :length => { :maximum => 100 }, 
                      :format => { :with => /\A[^[:cntrl:]\\<>\/&]*\z/ }
            validates :user_email, :presence => true, :length => { :within => 6..100 }, 
                      :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
            validates :content, :presence => true, :length => { :maximum => 500 }
            validates :commentable_type, :presence => true, :inclusion => { :in => %w( Post Broadcast ) }
            
            validates :author_type, :inclusion => { :in => %w( User Client ) }, :allow_blank => true
            
            before_validation :make_author
            
            scope :follows, where(:is_follow => true)
          end
        end
      end
      
      module InstanceMethods
        def comments_count
          @comments_count ||= self.class.count(:conditions=>["commentable_id = ? AND commentable_type = ?", self.commentable_id, self.commentable_type])
          @comments_count
        end
    
        private
    
          def make_author
          	unless self.author.nil?
            	self.user_email = self.author.email
            	self.user_name = self.author.name
          	end
          end
      end
    end
  end
end
