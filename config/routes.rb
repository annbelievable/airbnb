Rails.application.routes.draw do

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]

  resource :session, controller: "clearance/sessions", only: [:create]
  resources :users, except: [:new, :create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
    resources :listings
    resources :reservations
  end

  #for tagging
  resources :tags

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  root 'users#home'
  #for oauth facebook login
  #get '/auth/:provider/callback', to: 'sessions#create'
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  #added a route for all the listings
  get "/listings" => "listings#index"
  get "/listing/:id" => "listings#show"

  #for creating reservations
  post '/users/:user_id/reservations' => 'reservations#create', :as => :create_reservation

  #for braintree, payment
  get 'braintree/new'
  post 'braintree/checkout'

end
