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
    get 'admin_page' => 'apikeys#admin_page', as: :admin_page

    get 'admin_login_page' => 'users#admin_login_page', as: :admin_login_page

    post  'login'   =>  'users#login',  :as  => "login"
    get  'user_root'   =>  'apikeys#show',  :as  => "user_root"
    post  'admin_login'   =>  'users#admin_login',  :as  => "admin_login"
    get   'logout'  =>  'users#logout', as: :logout

    get   'revoke_key'  =>  'users#revoke_key', as: :revoke_key

    get   'generate_access_token' => 'users#generate_access_token', as: :generate_access_token

    get   'admin_revoke_key/(:user)'  =>  'admin_login#admin_revoke_key', as: :admin_revoke_key


    namespace :api, path: '/api' do
      scope "/v1" do

        resources :doodles do
          resources :end_users
        end

        get 'user/:end_user_id/doodles' => 'end_users#getUsersDoodles', as: :user_doodles
        
        get 'users' => 'end_users#index', as: :users_index

        post 'user' => 'end_users#create', as: :user_create

        get 'locations' => 'doodles#getAllLocations', as: :locations

        get 'tags' => 'tags#index', as: :tags

        post 'api_auth' => 'end_users#api_auth', as: :api_auth

        get 'doodles_by_tag/:tag_name' => 'doodles#doodles_by_tag', as: :doodles_by_tag

        get 'users/:id' => 'end_users#show', as: :show_end_user



        get 'users/:end_user_username/doodles' => 'end_users#getDoodlesByUsername', as: :show_doodles_username

      end
    end











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
