Rails.application.routes.draw do
  get 'games/new'
  get 'sessions/new'
  get 'users/new'
  # ルートページ
  root 'static_pages#home'

  get '/help', to:'static_pages#help'
  get '/about', to:'static_pages#about'
  get '/contact', to:'static_pages#contact'
  get  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # user
  resources :users do
    member do
      get :following, :followers
    end
    get :favorites, on: :collection
  end
  # game
  resources :games do
    resource :favorites, only: [:create, :destroy]
  end

  end
  # post
  resources :posts, only: [:create, :destroy]
  # relationship
  resources :relationships, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
