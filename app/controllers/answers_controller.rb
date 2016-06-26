class AnswersController < ApplicationController
  before_action :set_answer, only: [:destroy]

  def create

  end

  def destroy
    @answer.destroy

    redirect_to question_path(@answer.question)
  end

  private
    def answer_params
      params.require(:answer).permit(:body).merge(user: current_user)
    end

    def set_answer
      @answer = Answer.find(params[:id])
    end

end
