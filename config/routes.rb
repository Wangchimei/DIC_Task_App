Rails.application.routes.draw do
  root to: 'tasks#index'

  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users do
      member do
        get :toggle_admin
      end
    end
  end
end
