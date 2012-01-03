MusicLibrary::Application.routes.draw do
  
  match 'admin/menu' => 'admin#menu'
  match 'admin' => 'admin#index'
  match 'admin/login' => 'admin#login'
  match 'admin/logout' => 'admin#logout'
  match 'music/list' => 'public#list'
  match 'music/addcart/:id' => 'public#add_to_cart'
  match 'music/cart' => 'public#show_cart'
  match 'music/cartempty' => 'public#empty_cart'
  match 'music/removeitem/:id' => 'public#remove_item'
  match 'music/checkout' => 'public#checkout'
  match 'music/receipt/:id' => 'public#show_receipt'
  match 'music/saveorder' => 'public#save_order'
  
  resources :users

  resources :customers

  resources :orders

  resources :features
 
  resources :artists
  
  resources :albums
  
  match 'refresher/album_list' => 'public#album_list'
  match 'refresher/alt_album_list' => 'public#alt_album_list'
  match 'refresher/show_album' => 'public#show_album'
  match 'refresher/show/:id' => 'public#show'
  match 'refresher/create' => 'public#create'
  match 'refresher/new' => 'public#new'
  match 'refresher/list' => 'public#list'
  match 'refresher/edit/:id' => 'public#edit'
  match 'refresher/update/:id' => 'public#update'
  match 'refresher/destroy/:id' => 'public#destroy'
  
  resources :refresher

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
