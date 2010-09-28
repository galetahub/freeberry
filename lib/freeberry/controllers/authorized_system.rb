module Freeberry
  module Controllers
    module AuthorizedSystem
      def self.included(base)
        base.send(:extend, ClassMethods)
        base.send(:include, InstanceMethods)
        
        # Send current_user to Declarative authorization module
        base.before_filter :set_current_user
        
        base.helper_method :content_manager?, :current_client, :client_logged_in?, :account_signed_in?
      end
    
      module ClassMethods
      end

      module InstanceMethods
        protected
        
        # set_current_user sets the global current user for this request. This
        # is used by model security that does not have access to the
        # controller#current_user method. It is called as a before_filter.
        def set_current_user
          Authorization.current_user = current_user
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
        
        # For RPXNow
        def client_logged_in?
          !!current_client
        end
        
        def current_client=(new_client)
          session[:client_id] = new_client ? new_client.id : nil
          @current_client = new_client || false
        end
        
        def current_client
          @current_client ||= client_login_from_session unless @current_client == false
        end
        
        def client_login_from_session
          self.current_client = RpxClient.find_by_id(session[:client_id]) if session[:client_id]
        end
        
        def account_signed_in?
          user_signed_in? || client_logged_in?
        end
      end
    end
  end
end
