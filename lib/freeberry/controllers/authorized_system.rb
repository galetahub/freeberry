module Freeberry
  module Controllers
    module AuthorizedSystem
      def self.included(base)
        base.send(:extend, ClassMethods)
        base.send(:include, InstanceMethods)
      end
    
      module ClassMethods
        def self.extended(base)
          base.class_eval do
            skip_before_filter :set_current_user
            
            # Send current_user to Declarative authorization module
            before_filter :set_current_user
        
            helper_method :content_manager?
          end
        end
      end

      module InstanceMethods
        protected
        
        # set_current_user sets the global current user for this request. This
        # is used by model security that does not have access to the
        # controller#current_user method. It is called as a before_filter.
        def set_current_user
          without_access_control do
            Authorization.current_user = current_user
          end
        end
        
        def permission_denied
          flash[:error] = I18n.t(:access_denied, :scope => [:flash, :users])
          
          respond_to do |format|
            format.html { redirect_to new_session_path(:user) }
            format.xml  { head :unauthorized }
            format.js   { head :unauthorized }
          end
        end
        
        def without_access_control(&block)
          previous_state = Authorization.ignore_access_control
          begin
            Authorization.ignore_access_control(true)
            yield
          ensure
            Authorization.ignore_access_control(previous_state)
          end
        end
        
        def content_manager?
          user_signed_in? && current_user.admin?
        end
      end
    end
  end
end
