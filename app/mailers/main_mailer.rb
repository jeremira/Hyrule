class MainMailer < ApplicationMailer
  default from: "jmiraille@gmail.com"

  def greeting_email(user)
    @user = user
    mail(to: @user.email, subject: 'Bienvenue sur Krakoukas')
  end

end
