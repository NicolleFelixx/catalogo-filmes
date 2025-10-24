class SetupController < ApplicationController
  def seed
    # Verifica se já tem filmes (para não rodar 2x)
    if Movie.count > 0
      render json: { 
        message: "Seeds já foram executados! Já existem #{Movie.count} filmes no banco.",
        status: 'already_done'
      }
      return
    end
    
    begin
      # Roda os seeds
      load Rails.root.join('db/seeds.rb')
      
      render json: { 
        message: "Seeds executados com sucesso! ✅",
        users: User.count,
        categories: Category.count,
        movies: Movie.count,
        status: 'success'
      }
    rescue => e
      render json: { 
        message: "Erro ao executar seeds: #{e.message}",
        status: 'error'
      }, status: 500
    end
  end
end