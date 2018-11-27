Rails.application.routes.draw do
  resources :posts
  resources :comments
  get 'home/index'
  root to: "posts#index"
  devise_for :users
  patch "/posts/:id/like", to: "posts#like", as: "like"
  post '/create', to: 'posts#create', as: 'create'
  patch '/posts/:id/edit', to: 'posts#edit', as: 'edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
