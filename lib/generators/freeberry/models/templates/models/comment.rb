class Comment < ActiveRecord::Base
  include Freeberry::Models::Comment
  
  using_access_control
  
  attr_accessible :user_name, :user_email, :content, :is_follow

  auto_html_for :content do
    html_escape
    image
    youtube :width => 500, :height => 300
    vimeo :width => 500, :height => 300
    link :target => "_blank", :rel => "nofollow"
    simple_format
    sanitize
  end
end
