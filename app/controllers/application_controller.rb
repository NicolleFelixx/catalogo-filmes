class ApplicationController < ActionController::Base
  # Carregar categorias para a navbar em todas as páginas
  before_action :load_categories
  
  private
  
  def load_categories
    @categories = Category.ordered_by_name if Category.table_exists?
  end
end