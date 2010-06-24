authorization do
  role :guest do
    has_permission_on :users, :to => [:create, :update]
    has_permission_on :accounts, :to => [:show, :create]
    has_permission_on :comments, :to => [:read, :create]
  end
  
  role :default do
    has_permission_on :accounts, :to => [:show]
    has_permission_on :accounts, :to => [:update] do
      if_attribute :id => is {user.id}
    end
    
    has_permission_on :users, :to => [:update] do
      if_attribute :id => is {user.id}
    end
        
    has_permission_on :comments, :to => [:read, :create]
    has_permission_on :comments, :to => [:update, :delete] do
      if_attribute :author => is {user}
    end
  end
  
  role :admin do
    # Models
    has_permission_on :users, :to => :manage
    has_permission_on :comments, :to => :manage
    has_permission_on :accounts, :to => :manage
    
    # Administration module
    has_permission_on :manage_structures, :to => :manage
    has_permission_on :manage_users, :to => [:manage, :activate]
    has_permission_on :manage_pages, :to => :manage
    has_permission_on :manage_pictures, :to => :manage
    has_permission_on :manage_assets, :to => :manage
    has_permission_on :manage_posts, :to => :manage    
    has_permission_on :manage_settings, :to => :manage
    
    has_permission_on :authorization_rules, :to => :read
    has_permission_on :authorization_usages, :to => :read
  end
end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read,   :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
