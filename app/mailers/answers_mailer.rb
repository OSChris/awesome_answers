class AnswersMailer < ActionMailer::Base
  default from: "from@example.com"

  def notify_question_owner(answer)
    @answer  = answer
    @question = @answer.question
    @user     = @question.user
    mail(to: @user.email, subject: "#{@answer.user.name_display} posted an answer for your question: #{@question.title}.")
  end


end
