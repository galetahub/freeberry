class Structure < ActiveRecord::Base
  include Freeberry::Models::Structure
  
  acts_as_nested_set
  
  has_slug :prepend_id => false
  
  attr_accessible :title, :kind, :position, :parent_id, :redirect_url
end
