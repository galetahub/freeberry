class Comment < ActiveRecord::Base
  include Freeberry::Models::Comment
  
  using_access_control
  
  validates :content, :presence => true, :length => { :maximum => 500 }
  validates :commentable_type, :presence => true, :inclusion => { :in => %w( Post Article ) }         
  validates :author_type, :inclusion => { :in => %w( User Client ) }, :allow_blank => true
  
  attr_accessible :user_name, :user_email, :content, :is_follow

  auto_html_for :content do
    html_escape
    big_words :length => 80, :tag => "span"
    image
    youtube :width => 500, :height => 300
    vimeo :width => 500, :height => 300
    link :target => "_blank", :rel => "nofollow"
    simple_format
    sanitize
  end
end
