BlogTest::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  resources :posts do
  	resources :comments 
  end
  resources :users 
  resources :sessions

#member do get 'create' end
  #match '/posts' => 'posts#index', :as => "posts", :method => :get
  #match '/posts/:id' => 'posts#show', :as => "post",  :method => :get 
  #match '/posts/new' => 'posts#new', :as => "new_post", :method => :get 
  #match '/posts' => 'posts#create', :method => :post 
  #match '/posts/:id' => 'posts#update', :method => :put 
  #match '/posts/:id' => 'posts#destroy',  :method => :delete 
  

#    posts GET    /posts(.:format)          {:action=>"index", :controller=>"posts"}
#          POST   /posts(.:format)          {:action=>"create", :controller=>"posts"}
# new_post GET    /posts/new(.:format)      {:action=>"new", :controller=>"posts"}
#edit_post GET    /posts/:id/edit(.:format) {:action=>"edit", :controller=>"posts"}
#     post GET    /posts/:id(.:format)      {:action=>"show", :controller=>"posts"}
#          PUT    /posts/:id(.:format)      {:action=>"update", :controller=>"posts"}
#          DELETE /posts/:id(.:format)      {:action=>"destroy", :controller=>"posts"}


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
  # match ':controller(/:action(/:id(.:format)))'
end
