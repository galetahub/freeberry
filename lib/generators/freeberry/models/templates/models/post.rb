class Post < ActiveRecord::Base
  include Freeberry::Post
  attr_accessible :published_at, :content, :title
end
