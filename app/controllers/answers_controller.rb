class AnswersController < ApplicationController

  before_action :authenticate_user!
  before_action :b4_destroy, only: [:destroy]

  def create
    @question    = Question.find(params[:question_id])
    @answer      = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to @question, notice: "Answer created successfully"
    else
      render "questions/show"
      flash.now[:alert] = "Something went wrong when saving your answer."
    end
  end

  def destroy
    if @answer.destroy
      redirect_to @question, notice: "Answer successfully deleted."
    end
  end

  private

  def b4_destroy
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

end
