class LikesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_question

  def create
    @like = @question.likes.new
    @like.user = current_user
    if @like.save
      redirect_to @question, notice: "Liked!"
    else
      redirect_to @question, alert: "Couldn't like"
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    if @like.destroy
      redirect_to @question, notice: "I didn't like that question anyway"
    else
      redirect_to @question, alert: "Couldn't unlike that"
    end
  end

  private

  def find_question
    @question = Question.find params[:question_id]
  end
end
