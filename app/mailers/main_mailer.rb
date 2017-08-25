class MainMailer < ApplicationMailer
  default from: "contact@tokyhop.fun"

  def greeting_email(user)
    @user = user
    mail(to: @user.email, subject: 'Bienvenue sur Tokyhop!')
  end

  def booking_email(user, trip)
    @user = user
    @trip = trip
    mail(to: @user.email, subject: 'Réservation de votre séjour Tokyhop!')
  end

  def ready_email(user, trip)
    @user = user
    @trip = trip
    mail(to: @user.email, subject: 'Votre voyage Tokyhop! est prêt !')
  end

  def payed_email(user, trip)
    @user = user
    @trip = trip
    mail(to: @user.email, subject: 'Confirmation de paiement de votre voyage Tokyhop!.')
  end

  def livret_ready_email(user)
    @user = user
    mail(to: @user.email, subject: 'Le programme de votre séjour Tokyhop! est disponible !')
  end

end
