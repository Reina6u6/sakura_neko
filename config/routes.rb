Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users

  resources :post_images, only: [:new, :index, :show]

  get "homes/about", to: "homes#about", as: "about"
end
