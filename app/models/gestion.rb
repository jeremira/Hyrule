class Gestion < ApplicationRecord
  belongs_to :trip
  validates :status, presence: true


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
