Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :sessions
  resources :users
  resources :tasks do
    collection do
      post :confirm
    end
  end
end
