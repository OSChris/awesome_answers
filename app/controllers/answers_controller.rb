class AnswersController < ApplicationController

  before_action :authenticate_user!
  before_action :b4_destroy, only: [:destroy]

  def create
    @question    = Question.find(params[:question_id])
    @answer      = @question.answers.new(answer_params)
    @answer.user = current_user
    respond_to do |format|  
      if @answer.save
        #AnswersMailer.notify_question_owner(@answer).deliver  
        format.html {redirect_to @question, notice: "Answer created successfully"}
        format.js   { render } # create.js.haml
      else
        render "questions/show"
        flash.now[:alert] = "Something went wrong when saving your answer."
      end
    end
  end

  def destroy
    respond_to do |format|
      if @answer.destroy
        format.html { redirect_to @question, notice: "Answer successfully deleted." }
        format.js { render }
      end
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
