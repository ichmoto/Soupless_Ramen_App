Rails.application.routes.draw do
  root to: "home#top"
  get 'tagsearches/search', to: 'tagsearches#search'
  get 'maps/index'
  resources :maps, only: [:index]
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, :posts
  end
  devise_for :users
  resources :users do
   member do
    get :favorite
   end
  end
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resources :favorite
  end
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

end
