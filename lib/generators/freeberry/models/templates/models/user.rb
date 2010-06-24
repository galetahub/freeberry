class User < ActiveRecord::Base
  include Freeberry::User
  
  using_access_control
  
  # Include default devise modules.
  devise :database_authenticatable, :confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
  
  def to_param
    "#{id}-#{login}"
  end
end
