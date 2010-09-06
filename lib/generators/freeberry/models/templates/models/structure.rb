class Structure < ActiveRecord::Base
  include Freeberry::Models::Structure
  
  acts_as_nested_set
  has_slug :prepend_id => false
end
