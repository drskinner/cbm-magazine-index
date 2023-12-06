Rails.application.routes.draw do
  root 'public#welcome'

  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  get 'public/about'
  get 'public/search'
  get 'public/status'
  get 'public/welcome'

  get 'public/article/:id', to: 'public#article'

  resources :articles
  resources :issues
  resources :magazines
end
