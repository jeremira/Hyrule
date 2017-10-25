# Preview all emails at http://localhost:3000/rails/mailers/main_mailer
class MainMailerPreview < ActionMailer::Preview

  def greeting_email
    MainMailer.greeting_email(User.first)
  end

  def booking_email
    MainMailer.booking_email(User.first, Trip.first)
  end

  def ready_email
    MainMailer.ready_email(User.first, Trip.first)
  end

  def payed_email
    MainMailer.payed_email(User.first, Trip.first)
  end

  def livret_ready_email
    MainMailer.livret_ready_email(User.first, Trip.first)
  end

end
