class Page < ActiveRecord::Base
  include Freeberry::Models::Page
  
  attr_accessible :title, :content
end
