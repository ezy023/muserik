SampleApp::Application.routes.draw do

  

  resources :users do
             resources :private_messages do
               collection do
                 post :delete_selected
               end
             end
           end

  resources :authentications

  resources :users do
  	member do
  		get :following, :followers
  	end
  end
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy, :index, :show, :update]
  resources :relationships, only: [:create, :destroy]
  resources :retweetings, only: [:create, :destroy]
  resources :password_resets
  resources :messages # for sending emails
  resources :invitations
  resources :comments, only: [:destroy]
  
  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match 'microposts/soundcloud', to: 'microposts#soundcloud_song', :as => :soundcloud
  match '/auth/:provider/callback' => 'authentications#create'

  root to: 'static_pages#home'

  match '/help', to: 'static_pages#help'
  match '/about', to: 'static_pages#about'
  match '/terms', to: 'static_pages#terms'
  match '/privacy', to: 'static_pages#privacy'
  match '/contact', to: 'messages#new'
  match '/advertisement', to: 'messages#new'
  match '/by_top', to: 'static_pages#home_top'

  match '/signup/:invitation_token', :controller => 'users', :action => 'new'

  resources :microposts do
    member do
      get :retweet
      put 'vote_up'
      put 'vote_down'
    end
  end

resources :microposts, only: :show do
  resources :comments, only: [:create] do
  end
end

resources :comments do
  member do
    put 'vote_up'
    put 'vote_down'
  end
end
 
 # For user profile vanity urls, current keeps redirecting to user id urls
  # match "/:username", to: "users#show"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
