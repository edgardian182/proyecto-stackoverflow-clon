class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:destroy]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to @question
    else
      # Si no se crea la respuesta se necesita que @question pase a la vista para poder renderizar correctamente todas sus caracteristicas
      @question = Question.find(params[:question_id])
      @comment = Comment.new
      render "questions/show/"
    end
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
