class MyQuestionsController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @my_questions = current_user.questions
  end


  private



end
