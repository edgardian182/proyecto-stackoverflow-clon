class CommentsController < ApplicationController

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      redirect_to commentable_url(find_commentable), notice: "The comment was successfully created"
    else
      @question = Question.find(params[:question_id])
      @answer = Answer.new
      render 'questions/show'
    end
  end

  def destroy
    @commentable = find_commentable
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy

    redirect_to commentable_url(find_commentable)
  end


  private
    def comment_params
      params.require(:comment).permit(:body).merge(user: current_user)
    end

    def find_commentable
      # Si en los Params existe un question_id, @commentable será la pregunta con ese ID sino, el @commentable será una Answer
      if params[:answer_id]
        Answer.find(params[:answer_id])
      else
        Question.find(params[:question_id])
      end
    end

    # Si el commentable tiene la misma clase y tipo de Question se dirige al path de esa Instance Variable, de lo contrario a la de Answer
    def commentable_url(commentable)
      if Question === commentable
        question_path(commentable)
      else
        # Como las respuestas están en la misma ruta del SHOW de la Pregunta, le redireccionamos al mismo lugar que si hubiesemos utilizado el Model Question en este caso
        question_path(commentable.question_id)
        # answer_path(commentable)
      end
    end
end
