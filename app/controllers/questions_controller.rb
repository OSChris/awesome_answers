class QuestionsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
    @question = Question.new
  end

  def new 
    @question = Question.new
  end

  def create
    @question      = Question.new(question_params)
    @question.user = current_user
    respond_to do |format|
      if @question.save
        format.html { redirect_to questions_path, notice: "Question Created Successfully" }
        format.js { render }
      else
        format.html do 
          flash.now[:alert] = "Problem saving question"
          render :new
        end
        format.js { render }
      end
    end
  end

  def show
    @answer = Answer.new
    @answers = @question.answers.order("created_at DESC")
    @favorite = @question.favorites.where(user: current_user).first
    @like = @question.likes.where(user: current_user).first
  end

  def edit
    respond_to do |format|
      format.js { render }
    end
  end

  def update
    respond_to do |format|
      if @question.update_attributes(question_params)
        format.html { redirect_to @question, notice: "Question Updated Successfully" }
        format.js   { render }
      else
        flash.now[:alert] = "Problem updating question"
        format.html { render :edit }
        format.js   { render }
      end
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_path, notice: "Question Deleted Successfully" }
      format.js   { render }
    end
  end


  private

  def question_params
    params.require(:question).permit(:title, :description, {category_ids: []})
  end

  def find_question
    @question = Question.find(params[:id])
  end


end
