class SetupController < ApplicationController
  before_action :only_admin

  def index

    @pending_trips = []
    Trip.all.each do |trip|  #TODO has to be done with an activerecord query, thats shit
      if trip.gestion.status == 'pending'
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
