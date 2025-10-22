class Comment < ApplicationRecord
  # Relações
  belongs_to :movie
  belongs_to :user, optional: true
  
  # Validações
  validates :content, presence: true, length: { minimum: 1, maximum: 1000 }
  validates :name, presence: true, if: -> { user.nil? }
  
  # Scopes
  scope :ordered_by_newest, -> { order(created_at: :desc) }
  
  # Método para retornar o nome do comentarista
  def commenter_name
    user&.email || name
  end
end