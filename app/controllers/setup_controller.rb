class SetupController < ApplicationController
  before_action :only_admin
  #This controller is for admin page control
  def index
    @themes = Theme.all
    @users_registered = User.count
    @all_trips = Trip.all
    @trips_total = @all_trips.count
    @last_trips = Trip.last(5)

    @pending_trips = []
    Trip.all.each do |trip|  #TODO has to be done with an activerecord query, thats shit
      if trip.gestion.status == 'approved'
        @pending_trips << trip
      end
    end

    @payed_trips = []
    Trip.all.each do |trip|  #TODO has to be done with an activerecord query, thats shit
      if trip.gestion.status == 'payed'
        @payed_trips << trip
      end
    end

    @final_trips = []
    Trip.all.each do |trip|  #TODO has to be done with an activerecord query, thats shit
      if trip.gestion.status == 'final'
        @final_trips << trip
      end
    end

  end

end
