class QuestionsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def new 
    @question = Question.new
  end

  def create
    @question      = Question.new(question_params)
    @question.user = current_user
    if @question.save
      redirect_to questions_path, notice: "Question Created Successfully"
    else
      flash.now[:alert] = "Problem saving question"
      render :new
    end
  end

  def show
    @answer  = Answer.new
    @comment = Comment.new
  end

  def edit

  end

  def update
    if @question.update_attributes(question_params)
      redirect_to @question, notice: "Question Updated Successfully"
    else
      flash.now[:alert] = "Problem updating question"
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: "Question Deleted Successfully"
  end


  private

  def question_params
    params.require(:question).permit(:title, :description)
  end

  def find_question
    @question = Question.find(params[:id])
  end


end
