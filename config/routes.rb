Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'rankings#index'

  resources :users do
    resources :candidates
    resources :residents do
      resources :rankings
    end
  end

  namespace :api do
    resources :zillow do
      post 'search', on: :collection
    end
  end
end
