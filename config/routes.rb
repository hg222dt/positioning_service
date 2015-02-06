Rails.application.routes.draw do
  get 'admin_login/index'

  get 'users/index'

  get 'user/index'

  get 'register/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'users#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
     #resources :register
     resources :users 

    get 'apikeys' => 'apikeys#show', as: :apikey
    get 'admin_page' => 'users#admin_page', as: :admin_page

    get 'admin_login_page' => 'users#admin_login_page', as: :admin_login_page

    post  'login'   =>  'users#login',  :as  => "login"
    post  'admin_login'   =>  'users#admin_login',  :as  => "admin_login"
    get   'logout'  =>  'users#logout', as: :logout

    get   'revoke_key'  =>  'users#revoke_key', as: :revoke_key

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
