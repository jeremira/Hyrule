class MainMailer < ApplicationMailer
  default from: "contact@tokyhop.fun"

  def greeting_email(user)
    @user = user
    mail(to: @user.email, subject: 'Bienvenue sur Tokyhop!')
  end

end
