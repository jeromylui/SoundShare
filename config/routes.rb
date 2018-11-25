Rails.application.routes.draw do
  resources :posts
  get 'home/index'
  root to: "posts#index"
  devise_for :users
  patch "/posts/:id/like", to: "posts#like", as: "like"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
