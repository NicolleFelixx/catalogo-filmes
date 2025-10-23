class MovieCategory < ApplicationRecord
  belongs_to :movie
  belongs_to :category
  
  # Validação para evitar duplicatas
  validates :movie_id, uniqueness: { scope: :category_id }
end