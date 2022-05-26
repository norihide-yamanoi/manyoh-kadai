Rails.application.routes.draw do
  resources :labels
  root to: 'tasks#index'
  resources :sessions
  resources :users
  namespace :admin do
    resources :users do
      collection do
        post :confirm
      end
    end
  end
  resources :tasks do
    collection do
      post :confirm
    end
  end
end
