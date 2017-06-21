Rails.application.routes.draw do
  get 'sessions/new'

  get 'static_pages/home'

  get 'static_pages/help'

  get 'static_pages/about'

  get 'static_pages/contact'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login',  to: 'sessions#new'
  post '/login',  to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#layout'
end
