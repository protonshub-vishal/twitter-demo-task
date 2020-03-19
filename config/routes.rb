Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  devise_for :users, skip: [:registrations, :sessions]
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      devise_for :users, controllers: { sessions: 'api/v1/sessions', registrations: 'api/v1/registrations' } 
    	
    	# Tweet Routes
    	resources :tweets, only:[:create, :destroy, :index, :show]
			
			# User Routes
			get 'user_profile', to: 'users#user_profile'     	
      get 'followers_tweets', to: 'users#followers_tweets'
      get 'user_followers', to: 'users#user_followers'
      
      # Relationship Routes
      get 'follow', to: 'relationships#follow_user'
      get 'unfollow', to: 'relationships#unfollow_user'
    end
  end
end
