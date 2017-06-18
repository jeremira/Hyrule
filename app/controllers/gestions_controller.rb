class GestionsController < ApplicationController
  before_action :set_trip_and_gestion

  def update
    case params[:status]
    when 'new'

    when 'pending'
      if current_user == @trip.user && @gestion.status == 'new'
        @gestion.status = 'pending'
        if @gestion.save
          flash[:notice] = "Thank you, we will now review your trip."
        else
          flash[:alert] = "Could not save change to this trip."
        end
      else
        flash[:alert] = "You're not allowed to do this change."
      end

    when 'approved'
      if current_user.admin && @gestion.status == 'pending'
        @gestion.status = 'approved'
        if @gestion.save
          flash[:notice] = "This trip has been approved."
        else
          flash[:alert] = "Could not save change to this trip."
        end
      else
        flash[:alert] = "You're not allowed to do this change."
      end

    when 'payed'

    when 'confirmed'

    when 'done'

    else
      flash[:alert] = "Got an invalid status : #{params[:status]}"
    end
    redirect_back(fallback_location: root_url)
  end

  private
    def set_trip_and_gestion
      @trip    = Trip.find(params[:trip_id])
      @gestion = @trip.gestion
    end

end
