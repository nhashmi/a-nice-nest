Rails.application.routes.draw do
  devise_for :users
  # root 'pages#search'

  resources :users do
    resources :candidates
    resources :residents
  end

  namespace :api do
    resources :zillow do
      post 'search', on: :collection
    end
  end

end
