class User < ActiveRecord::Base
  include Freeberry::User
  
  using_access_control
  
  # Include default devise modules.
  devise :database_authenticatable, :confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation
  
#  acts_as_attach_file :avatar
  
  def to_param
    "#{id}-#{login}"
  end
end
