Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'rankings#index'

  resources :users do
    resources :candidates
    resources :rankings
  end

  namespace :api do
    resources :zillow do
      post 'search', on: :collection
      post 'detailed_search', on: :collection
    end
  end
end
