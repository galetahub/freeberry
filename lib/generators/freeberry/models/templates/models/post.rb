class Post < ActiveRecord::Base
  include Freeberry::Models::Post
  
  attr_accessible :published_at, :content, :title
  
#  scope :visible, where(:is_visible => true)
end
