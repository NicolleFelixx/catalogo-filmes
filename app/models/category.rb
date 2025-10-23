class Category < ApplicationRecord
  # Relacionamentos
  has_many :movie_categories, dependent: :destroy
  has_many :movies, through: :movie_categories
  
  # Validações
  validates :name, presence: true, uniqueness: true
  
  # Scopes
  scope :ordered_by_name, -> { order(:name) }
end