Rails.application.routes.draw do
  root to: "home#top"
  get 'tagsearches/search', to: 'tagsearches#search'
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end
  devise_for :users
  resources :users
  resources :posts
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

end
