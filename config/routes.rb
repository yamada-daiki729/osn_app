Rails.application.routes.draw do
  get "/", to: "pages#home", as: :root
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get '/search', to: 'searches#index', as: :search
  get '/dashboard', to: 'dashboard#index', as: :dashboard
  get 'first_password_change', to: 'passwords#first_change', as: :first_password_change
  patch 'update_first_password', to: 'passwords#update_first_password', as: :update_first_password

  resources :categories
  resources :courses
  resources :instructions

  namespace :admin do
    resources :users
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
