class Movie < ApplicationRecord
  # Relações
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  # Validações
  validates :title, presence: true, length: { minimum: 1, maximum: 200 }
  validates :synopsis, presence: true
  validates :release_year, presence: true, 
            numericality: { only_integer: true, greater_than: 1800, less_than_or_equal_to: 2100 }
  validates :duration, presence: true, 
            numericality: { only_integer: true, greater_than: 0 }
  validates :director, presence: true
  
  # Scopes (consultas pré-definidas)
  scope :ordered_by_newest, -> { order(created_at: :desc) }
  scope :ordered_by_oldest, -> { order(created_at: :asc) }
end