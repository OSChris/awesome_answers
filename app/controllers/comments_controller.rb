class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_answer
  before_action :find_comment, except: [:create]

  def create
    @comment      = @answer.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @answer.question, notice: "Comment posted!"
    else
      redirect_to @answer.question, alert: "Comment wasn't posted."
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes(comment_params)
      redirect_to @answer.question, notice: "Comment updated!"
    else
      flash.now[:alert] = "Something went wrong updating this comment"
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @answer.question, notice: "Comment deleted"
  end


  private

  def find_answer
    @answer = Answer.find params[:answer_id]
  end

  def find_comment
    @comment = @answer.comments.find params[:id]
  end

  def comment_params
    params.require(:comment).permit(:body)
  end


end
