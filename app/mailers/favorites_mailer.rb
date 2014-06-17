class FavoritesMailer < ActionMailer::Base
  default from: "do-not-reply@awesomeanswers.com"

  def notify_question_owner(question)
    @question  = question
    @user      = question.user

    mail(to: @user.email, subject: "Someone favorited your question
                                    #{@question.title}")
  end

end
