class FavoritesController < ApplicationController

  before_action :authenticate_user!, :find_question

  def create
    @favorite = @question.favorites.new
    @favorite.user = current_user
    if @favorite.save
      FavoritesMailer.delay.notify_question_owner(@question)
      redirect_to @question, notice: "I love that question too!"
    else
      redirect_to @question, alert: "Couldn't favorite"
    end
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    if @favorite.destroy
      redirect_to @question, notice: "I didn't like that question anyway"
    else
      redirect_to @question, alert: "Couldn't unfavorite that"
    end
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

end
