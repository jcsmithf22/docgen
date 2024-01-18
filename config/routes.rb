Rails.application.routes.draw do
  get 'invitations/new'
  get 'invitations/create'
  get 'invitations/index'
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  get "users/new", to: "registrations#new"
  post "users/new", to: "registrations#create"
  get "users", to: "users#index"
  resources :sessions, only: [:index, :show, :destroy]
  resource :password, only: [:edit, :update]
  namespace :identity do
    resource :email, only: [:edit, :update]
    resource :email_verification, only: [:show, :create]
    resource :password_reset, only: [:new, :edit, :create, :update]
  end
  resources :invitations, only: [:new, :create, :index]
  root "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end