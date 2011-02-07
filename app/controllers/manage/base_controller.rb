class Manage::BaseController < ApplicationController
  layout "manage"
  
  before_filter :authenticate_user!
  
  load_and_authorize_resource
  
  respond_to :html
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:failure] = exception.message
    flash[:failure] ||= I18n.t(:access_denied, :scope => [:flash, :users])
          
    respond_to do |format|
      format.html { redirect_to new_session_path(:user) }
      format.xml  { head :unauthorized }
      format.js   { head :unauthorized }
    end
  end
end
