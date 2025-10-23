class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authorize_movie, only: [:edit, :update, :destroy]

  # GET /movies (página pública)
  def index
    @movies = Movie.includes(:user)
                   .ordered_by_newest
                   .page(params[:page])
                   .per(6)
  end

  # GET /movies/:id (página pública)
  def show
    @comment = Comment.new
    @comments = @movie.comments.includes(:user).ordered_by_newest
  end

  # GET /movies/new (apenas autenticado)
  def new
    @movie = Movie.new
  end

  # POST /movies (apenas autenticado)
  def create
    @movie = current_user.movies.build(movie_params)
    
    if @movie.save
      redirect_to @movie, notice: 'Filme cadastrado com sucesso!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /movies/:id/edit (apenas dono)
  def edit
  end

  # PATCH/PUT /movies/:id (apenas dono)
  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Filme atualizado com sucesso!'
    else
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
def search_ai
  title = params[:title]
  
  if title.blank?
    render json: { error: 'Título não pode estar vazio' }, status: :unprocessable_entity
    return
  end
  
  begin
    result = MovieAiService.fetch_movie_data(title)
    
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
    params.require(:movie).permit(:title, :synopsis, :release_year, :duration, :director, :poster)
  end
end