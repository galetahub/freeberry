class Header < ActiveRecord::Base
  include Freeberry::Models::Header
  
  attr_accessible :title, :keywords, :description
end
