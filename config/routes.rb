Rails.application.routes.draw do
  resources :high_scores
  # root 'pages#hello'
  # GET /about
  get "about", to: "about#index"
  root  "main#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
