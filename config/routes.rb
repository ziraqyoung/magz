Rails.application.routes.draw do
  root to: 'pages#index'

  devise_scope :user do
    get '/login', to: 'devise/sessions#new'
    get '/signup', to: 'devise/registrations#new'
  end

  devise_for :users, controllers: { registrations: 'registrations' }
  resources :posts do
    collection do
      get 'hobby'
      get 'study'
      get 'team'
    end
  end

  namespace :private do
    resources :conversations do
      resources :messages, only: :create, module: :conversations
    end
  end

  resources :contacts, only: [:index, :create, :destroy, :update ]
  # resources :messages, only: [:index, :edit, :update, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
