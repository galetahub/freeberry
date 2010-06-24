class Manage::BaseController < ApplicationController
  layout "manage"
  filter_access_to :all
end
