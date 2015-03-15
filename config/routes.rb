Rails.application.routes.draw do

  # welcome page
  root   'accounts#welcome'

  # account routes
  get    'login'                          => 'accounts#login_form',         as: :login_form
  post   'login'                          => 'accounts#login',              as: :login_action
  get    'logout'                         => 'accounts#logout',             as: :logout
  get    'signup'                         => 'accounts#signup_form',        as: :signup_form
  post   'signup'                         => 'accounts#signup',             as: :signup_action
  get    'account'                        => 'accounts#show',               as: :account_show

  # friends routes
  get    'friends'                        => 'friends#index',               as: :friends
  get    'friends/search'                 => 'friends#search',              as: :friends_search_form
  get    'friends/search/:search_string'  => 'friends#search_action',       as: :friends_search_action
  get    'friends/:id'                    => 'friends#show',                as: :friends_show
  post   'friends/:id'                    => 'friends#add',                 as: :friends_add
  post   'friends/confirm/:id'            => 'friends#confirm',             as: :friends_confirm
  delete 'friends/:id'                    => 'friends#delete',              as: :friends_delete

  # games routes
  get    'games'                          => 'games#index',                 as: :games
  get    'games/search'                   => 'games#search',                as: :games_search_form
  get    'games/search/:search_string'    => 'games#search_action',         as: :games_search_action
  get    'games/:bgg_id'                  => 'games#show',                  as: :games_show
  post   'games/:bgg_id'                  => 'games#add',                   as: :games_add
  delete 'games/:bgg_id'                  => 'games#delete',                as: :games_delete

  # events routes
  get    'events'                         => 'events#index',                as: :events
  post   'events'                         => 'events#new_action',           as: :events_new
  get    'events/new'                     => 'events#new',                  as: :events_new_form
  get    'events/:id'                     => 'events#show',                 as: :events_show
  delete 'events/:id'                     => 'events#delete',               as: :events_delete


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
