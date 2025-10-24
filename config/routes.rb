Rails.application.routes.draw do
  # Devise (autenticação)
  devise_for :users
  
  # Página inicial
  root 'movies#index'
  
  # Rotas dos filmes (área pública e autenticada)
  resources :movies do
    get :search_ai, on: :collection
    resources :comments, only: [:create]
  end
  
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
  # Rota temporária para rodar seeds em produção
  get '/setup/seed', to: 'setup#seed'
end