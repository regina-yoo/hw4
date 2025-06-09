Rails.application.routes.draw do
  # home
  root "places#index"

  # signup
  get  "/signup", to: "users#new",    as: :signup
  post "/signup", to: "users#create"

  # login/logout
  get    "/login",  to: "sessions#new",     as: :login
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  # main resources
  resources :places
  resources :entries
end