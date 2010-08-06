# encoding: utf-8
module Freeberry
  module Models
    module User
      def self.included(base)
        base.send :include, InstanceMethods
        base.send :extend,  ClassMethods
      end
      
      module ClassMethods
        def self.extended(base)
          base.class_eval do
            before_validation :make_login
        
            has_many :roles, :dependent => :delete_all
            has_one :avatar, :as => :assetable, :dependent => :destroy
            
            scope :admins, joins(:roles).where(["`roles`.role_type = ?", ::RoleType.admin.id])
          end
        end
      end
      
      module InstanceMethods
        def manager?
	        has_role?(:manager)
	      end
	
	      def admin?
	        has_role?(:admin)
	      end
	
	      def has_role?(role_name)
	        role_symbols.include?(role_name.to_sym)
	      end
	
	      def roles_attributes=(value)
          options = value || {}
          options.each do |k, v|
            r = self.roles.detect { |r| r.role_type.id == k.to_i }
            if v.to_i == 0
              self.roles.delete(r) unless r.nil?
            else
              r ||= self.roles.build(:role_type => RoleType.find(k.to_i))
            end
          end
        end
	
	      def role_symbols
          (roles || []).map {|r| r.to_sym}
        end
        
        def state
          return 'active' if active?
          return 'register' unless confirmed?
          return 'suspend' if access_locked?
          'pending'
        end
        
        def events_for_current_state
          events = []
          events << 'activate' if state == 'register'
          events
        end
        
        private
    
          def make_login
	          return if self.email.blank?
	          
          	if self.login.blank?
          		tmp_login = self.email.split('@').first
          		tmp_login ||= ActiveSupport::SecureRandom.hex(7)
          		tmp_login = tmp_login.parameterize.downcase.gsub('.', '_')
          		tmp_login = [tmp_login, ActiveSupport::SecureRandom.hex(4)].join('_') unless self.class.find_by_login(tmp_login).nil?
          		self.login = tmp_login
          	end
          end
      end
    end
  end
end
