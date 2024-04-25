Rails.application.routes.draw do
  root to: "home#top"
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  devise_for :users
  resources :users
  resources :posts, only: [:new, :create, :index, :show, :destroy]
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

end
