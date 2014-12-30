Poc::Application.routes.draw do
  root to: "home#index"
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" , :sessions=> "users/sessions"} 
  
  match 'follow' => 'users#follow'
match 'unfollow' => 'users#unfollow'
match 'like' => 'users#like'
  
  resource :user  do
	resources :statuses
	member do
		get  'change_password', as:  "change_password"
		put 'editprofile'
		get 'admin_allusers'
		#get 'show', as: "show"
	end
  end
  resources :comments
   #match '/user/change_password' => "users#edit", :as => "change_password"
  #get '/user/:id' , to: "users#show", :as => "show"
  
  get '/home/generate_random_numbers' => "home#generate_random_numbers"
  get '/home/index/' => "home#index"
  devise_scope :user do
  get "sign_in", to: "devise/sessions#new"
end

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

  # Samplrce route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :pre resource route with options:
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

  # Sample resouoducts do
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
