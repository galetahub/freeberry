class User < ActiveRecord::Base
  include Freeberry::Models::User
  
  using_access_control
  
  # Include default devise modules.
  devise :database_authenticatable, :confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
#  acts_as_attach_file :avatar
  
  def to_param
    "#{id}-#{login}"
  end
end
