class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authorize_movie, only: [:edit, :update, :destroy]

  # GET /movies (página pública)
 def index
  @movies = Movie.includes(:user, :categories).ordered_by_newest
  
  # Filtro por categoria
  if params[:category_id].present?
    @movies = @movies.joins(:categories).where(categories: { id: params[:category_id] })
    @selected_category = Category.find(params[:category_id])
  end
  
  # Busca por título, diretor ou ano
  if params[:search].present?
    search_term = "%#{params[:search]}%"
    @movies = @movies.where(
      "title ILIKE ? OR director ILIKE ? OR CAST(release_year AS TEXT) LIKE ?",
      search_term, search_term, params[:search]
    )
  end
  
  @movies = @movies.distinct.page(params[:page]).per(6)
  @categories = Category.ordered_by_name
end

  # GET /movies/:id (página pública)
  def show
    @comment = Comment.new
    @comments = @movie.comments.includes(:user).ordered_by_newest
  end

  # GET /movies/new (apenas autenticado)
  def new
  @movie = Movie.new
  @categories = Category.ordered_by_name
end

  def create
  @movie = Movie.new(movie_params)
  @movie.user = current_user
  
  if @movie.save
    redirect_to @movie, notice: 'Filme cadastrado com sucesso!'
  else
    @categories = Category.ordered_by_name  # ← ADICIONE ESTA LINHA
    render :new, status: :unprocessable_entity
  end
end

  # GET /movies/:id/edit (apenas dono)
  def edit
  @categories = Category.ordered_by_name  # ← ADICIONE ESTA LINHA
end

  # PATCH/PUT /movies/:id (apenas dono)
  def update
  if @movie.update(movie_params)
    redirect_to @movie, notice: 'Filme atualizado com sucesso!'
  else
    @categories = Category.ordered_by_name  # ← ADICIONE ESTA LINHA
    render :edit, status: :unprocessable_entity
  end
end

  # DELETE /movies/:id (apenas dono)
  def destroy
    @movie.destroy
    redirect_to movies_url, notice: 'Filme excluído com sucesso!'
  end

  # GET /movies/search_ai
# GET /movies/search_ai
def fetch_ai_data
  title = params[:title]
  
  if title.blank?
    render json: { error: 'Título não pode estar vazio' }, status: :unprocessable_entity
    return
  end
  
  begin
    result = MovieAiService.fetch_movie_data(title)

    Rails.logger.info "========================================="
    Rails.logger.info "RESULTADO DA IA: #{result.inspect}"
    Rails.logger.info "========================================="
    
    # Verificar se houve erro relacionado a sobrecarga
    if result[:error]
      error_msg = result[:error].to_s.downcase
      
      if error_msg.include?('overloaded') || error_msg.include?('503')
        render json: { 
          error: '🤖 A IA está temporariamente sobrecarregada. Aguarde alguns minutos e tente novamente, ou preencha os campos manualmente.' 
        }
      elsif error_msg.include?('timeout')
        render json: {
          error: '⏱️ A busca está demorando muito. Tente novamente ou preencha manualmente.'
        }
      else
        render json: result
      end
    else
      render json: result
    end
    
  rescue => e
    Rails.logger.error("❌ Erro no search_ai: #{e.message}")
    render json: { 
      error: 'Serviço temporariamente indisponível. Por favor, preencha os campos manualmente.' 
    }
  end
end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def authorize_movie
    unless @movie.user == current_user
      redirect_to movies_path, alert: 'Você não tem permissão para fazer isso.'
    end
  end

  def movie_params
    params.require(:movie).permit(:title, :synopsis, :release_year, :duration, :director, :poster, category_ids: [])
  end
end