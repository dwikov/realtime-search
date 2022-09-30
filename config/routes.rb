Rails.application.routes.draw do
  resources :activities
  root :to => 'search#index'
  post 'match_all', to: 'search#match_all'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
