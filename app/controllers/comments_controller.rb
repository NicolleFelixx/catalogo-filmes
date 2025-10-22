class CommentsController < ApplicationController
  before_action :set_movie

  def create
    @comment = @movie.comments.build(comment_params)
    
    # Se usuário estiver logado, associa o comentário a ele
    @comment.user = current_user if user_signed_in?
    
    if @comment.save
      redirect_to @movie, notice: 'Comentário adicionado com sucesso!'
    else
      redirect_to @movie, alert: 'Erro ao adicionar comentário.'
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :name)
  end
end