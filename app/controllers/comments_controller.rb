class CommentsController < ApplicationController

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.create(comment_params)

    redirect_to commentable_url(find_commentable), notice: "The comment was successfully created"
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
      if params[:question_id]
        Question.find(params[:question_id])
      else
        Answer.find(params[:answer_id])
      end
    end

    # Si el commentable tiene la misma clase y tipo de Question se dirige al path de esa Instance Variable, de lo contrario a la de Answer
    def commentable_url(commentable)
      if Question === commentable
        question_path(commentable)
      else
        answer_path(commentable)
      end
    end
end