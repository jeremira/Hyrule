class Gestion < ApplicationRecord
  belongs_to :trip
  validates :status, presence: true


  def process_stripe_charge(amount, email, token)
    customer = Stripe::Customer.create(
      :email => email,
      :source  => token
    )
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => amount,
      :description => 'Séjour Tokyhop.fun',
      :currency    => 'eur'
    )
    self.update_attributes(:status => :payed,
                           :token => charge.id,
                           :payment_date => Time.now,
                           :amount_payed => amount)
  end

  #Condition to see if an User can make a booking demand for his trip
  def is_bookable?
    if self.trip.days.length > 0 && self.status == "new"
      return true
    else
      return false
    end
  end

  def book_trip
    self.status = 'approved'
  end

  #can only be call by Admin, can update From/To any status
  def update_status(new_status)
    if ['new', 'approved', 'payed', 'final', 'done'].include? new_status
      self.status = new_status
    else
      false
    end
  end

end
