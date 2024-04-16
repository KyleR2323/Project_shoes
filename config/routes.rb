Rails.application.routes.draw do
  #get 'provinces/index'
  #get 'brands/index'
  #get 'brands/show'
  #get 'home/index'
  #get 'contact/show'
  #get 'about/show'
  #get 'cart/index'
  #get 'shoes/index'
  #get 'shoes/show'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'home/index'
  get 'order/index'
  get 'contact/show'
  get 'about/show'
  get 'about', to: 'about#show'
  get 'contact', to: 'contact#show'

  get '/index', to:'home#index'
  get '/sale', to:'home#index'
  get '/new', to:'home#index'

  resources :shoes, only: [:index, :show] do
    collection do
      get "search"
    end
  end
  root 'home#index'
  resources :cart, only: [:create, :checkout, :destroy, :index, :update]
  resources :home
  resources :items
  resources :regions
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
