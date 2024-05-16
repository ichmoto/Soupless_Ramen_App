Rails.application.routes.draw do
  root to: "home#top"
  get 'tagsearches/search', to: 'tagsearches#search'
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, :posts
  end
  devise_for :users
  resources :users
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
  end
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  resource :favorite, only: [:create, :destroy]

end
