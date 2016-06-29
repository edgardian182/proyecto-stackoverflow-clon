class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all.order('created_at DESC')
    if params[:search].present?
      @questions = @questions.where("lower(title) LIKE ? OR lower(description) LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      redirect_to question_path(@question), notice: "Question was successfully created"
    else
      render 'new'
    end
  end

  def show
    @answer = Answer.new
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to root_path, notice: "Question was successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    @question.destroy
    redirect_to root_path, notice: "Question was successfully deleted"
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :description)
    end
end
