Rails.application.routes.draw do
  root 'public#welcome'

  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  get 'public/about'
  get 'public/status'
  get 'public/welcome'

  resources :articles
  resources :issues
  resources :magazines
end
