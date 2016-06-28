class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:destroy]

  def create
    question = Question.find(params[:question_id])
    question.answers.create(answer_params)

    redirect_to question
  end

  def destroy
    @answer.destroy

    redirect_to question_path(@answer.question_id)
  end

  private
    def answer_params
      params.require(:answer).permit(:body).merge(user: current_user)
    end

    def set_answer
      @answer = Answer.find(params[:id])
    end

end
