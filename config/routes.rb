Rails.application.routes.draw do
  get :root, to: 'welcome#index'

  resources :merchants do
    # resources :items, only: [:index]
    get '/items', to: 'items#index'
  end

  # resources :items, only: [:index, :show] do
  #   resources :reviews, only: [:new, :create]
  # end
  get '/items', to: 'items#index'
  get '/items/:id', to: 'items#show', as: 'item'
  post '/items/:item_id/reviews', to: 'reviews#create', as: 'item_reviews'
  get '/items/:item_id/reviews/new', to: 'reviews#new', as: 'new_item_review'

  # resources :reviews, only: [:edit, :update, :destroy]
  get '/reviews/:id/edit', to: 'reviews#edit', as: 'edit_review'
  patch '/reviews/:id', to: 'reviews#update', as: 'review'
  delete '/reviews/:id', to: 'reviews#destroy'

  # not 100% sure how to handle these routes as resources
  # everything I've been trying has beeon throwing a ton of errors due to the nature of the 
  # controller actions being called

  get '/cart', to: 'cart#show'
  post '/cart/:item_id', to: 'cart#add_item'
  delete '/cart', to: 'cart#empty'
  patch '/cart/:change/:item_id', to: 'cart#update_quantity'
  delete '/cart/:item_id', to: 'cart#remove_item'

  get '/registration', to: 'users#new', as: :registration

  # patch '/user/:id', to: 'users#update'
  resources :users, only: [:create, :update]

  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  get '/profile/edit_password', to: 'users#edit_password'
  post '/orders', to: 'user/orders#create'
  get '/profile/orders', to: 'user/orders#index'
  get '/profile/orders/:id', to: 'user/orders#show'
  delete '/profile/orders/:id', to: 'user/orders#cancel'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#logout'

  namespace :merchant do
    get '/', to: 'dashboard#index', as: :dashboard
    # resources :orders, only: :show
    get '/orders/:id', to: 'orders#show', as: :order
    resources :items, only: [:index, :new, :create, :edit, :update, :destroy]
    # get '/merchant/items', to: 'merchant/items#index'
    # post '/merchant/items', to: 'merchant/items#create'
    # get '/merchant/items/new', to: 'merchant/items#new', as: 'new_merchant_item'
    # get '/merchant/items/:id/edit', to: 'merchant/items#edit', as: 'edit_merchant_item'
    # patch '/merchant/items/:id', to: 'merchant/items#update', as: 'merchant_item'
    # delete '/merchant/items/:id', to: 'merchant/items#destroy'
    # put '/merchant/items/:id', to: 'merchant/items#change_status'
    # get '/merchant/orders/:id/fulfill/:order_item_id', to: 'merchant/orders#fulfill'
    
    put '/items/:id/change_status', to: 'items#change_status'
    get '/orders/:id/fulfill/:order_item_id', to: 'orders#fulfill'

    resources :discounts, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  end

  namespace :admin do
    get '/', to: 'dashboard#index', as: :dashboard
    resources :merchants, only: [:show, :update]
    resources :users, only: [:index, :show]
    patch '/orders/:id/ship', to: 'orders#ship'
  end
end
