class VotesController < ApplicationController
before_action :authenticate_user!

  def create
    @votable = find_votable
    @vote = @votable.votes.create(user: current_user)


    redirect_to votable_url(find_votable)
  end

  def destroy
    @votable = find_votable
    # El metodo try es: Si existe ejecuta sino NIL
    @vote = @votable.votes.where(user: current_user).take.try(:destroy)
    @vote.destroy

    redirect_to votable_url(find_votable)
  end

  private
    def find_votable
      if params[:answer_id]
        Answer.find(params[:answer_id])
      else
        Question.find(params[:question_id])
      end
    end

    def votable_url(votable)
      if Question === votable
        question_path(votable)
      else
        question_path(votable.question_id)
      end
    end
end
