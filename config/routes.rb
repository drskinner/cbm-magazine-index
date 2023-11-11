Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  get 'public/about'
  get 'public/status'

  resources :articles
  resources :issues
  resources :magazines
end
