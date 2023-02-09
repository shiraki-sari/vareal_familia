Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :gourmet_posts
  resources :users
  resources :sessions, only: %i[new create destroy]
end
