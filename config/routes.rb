Rails.application.routes.draw do
  get 'bookings/new'
  get 'spas/index'
  devise_for :users
  root to: "spas#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :spas do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:show, :destroy, :index]


  # Defines the root path route ("/")
  # root "posts#index"
end
