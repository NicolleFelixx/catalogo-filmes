Rails.application.routes.draw do
  # Devise (autenticação)
  devise_for :users
  
  # Página inicial
  root 'movies#index'
  
  # Rotas dos filmes (área pública e autenticada)
  resources :movies do
    resources :comments, only: [:create]
  end
  
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end