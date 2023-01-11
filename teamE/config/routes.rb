Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'gourmet_posts' => 'gourmet_posts#index'
  get 'gourmet_posts/new' => 'gourmet_posts#new'
  get 'gourmet_posts/:id' => 'gourmet_posts#show'
  post 'gourmet_posts' => 'gourmet_posts#create'
end
