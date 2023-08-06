Rails.application.routes.draw do
  resources :posts
  devise_for :users
  resources :comments
  post "new_user_like", to: "likes#new_user_like"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
end
