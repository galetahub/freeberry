Rails.application.routes.draw do |map|
  # Administration System
  namespace :manage do
	  resources :users do
	    member do
        post :activate, :suspend, :register, :delete, :unsuspend
      end
	  end
		
		resources :structures do
		  get :move, :on => :member
		  
		  resource :page
		  resources :posts
		end
		
    resources :settings
    resources :pictures
    resources :assets, :only=>[:create, :destroy]
  end
	
	match 'manage', :to => "manage/structures#index"
end
