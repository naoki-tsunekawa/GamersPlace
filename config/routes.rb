Rails.application.routes.draw do
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
  end

  # game
  resources :games do
    # ※resourceとresourcesでroutingのpathが異なるので注意
    resource :favoritegames, only: [:create, :destroy]

    resources :reviews, only: [:index, :create]

    collection do
      get 'search'
    end
  end

  # post
  resources :posts, only: [:create, :destroy]

  # relationship
  resources :relationships, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
