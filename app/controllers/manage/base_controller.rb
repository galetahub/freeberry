class Manage::BaseController < ApplicationController
  layout "manage"
  
  before_filter :authenticate_user!
  
  filter_access_to :all
  
  respond_to :html, :xml, :json
end
