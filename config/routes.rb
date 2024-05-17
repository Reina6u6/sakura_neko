Rails.application.routes.draw do
 scope module: :public do
  root to: "homes#top"
  devise_for :users
  get "homes/about", to: "homes#about", as: "about"
  resources :post_images, only: [:new, :create, :index, :show, :destroy, :edit] do
    collection do
      get :search
      get :tag
    end
    resources :post_comments, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update]
 end
  
  
 devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

 namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end

  
  
end
