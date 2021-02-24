Rails.application.routes.draw do
  resources :categories
  resources :articles
  resources :votes
  resources :users
  root "users#new"
  post "/users/logout", to: "users#logout"
  get "/votes/vote_up/:id", to: "votes#vote_up"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
