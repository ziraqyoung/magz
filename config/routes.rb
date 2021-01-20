Rails.application.routes.draw do
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

  root to: 'pages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
