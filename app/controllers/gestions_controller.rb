class GestionsController < ApplicationController
  before_action :set_trip_and_gestion

  def update
    case params[:status]
    when 'new'

    when 'pending'
      if current_user == @trip.user && @gestion.status == 'new'
        @gestion.status = 'pending'
        if @gestion.save
          flash[:notice] = "Merci de votre réservation. Nos équipes vont prendre en charge votre demande."
          MainMailer.booking_email(@trip.user, @trip).deliver
        else
          flash[:alert] = "Les changements n'ont pu être enregistrés"
        end
      else
        flash[:alert] = "Désolé, vous ne pouvez pas modifier ce voyage.."
      end

    when 'approved'
      if current_user.admin && @gestion.status == 'pending'
        @gestion.status = 'approved'
        if @gestion.save
          flash[:notice] = "Vous avez approuvé ce voyage."
          #asking for payment
          MainMailer.ready_email(@trip.user, @trip).deliver
        else
          flash[:alert] = "Les changements n'ont pu être enregistrés."
        end
      else
        flash[:alert] = "Vous n'êtes pas authorisé à effectuer cette opération."
      end

    when 'payed'

    when 'final'
      if current_user.admin && @gestion.status == 'payed'
        @gestion.status = 'final'
        if @gestion.save
          flash[:notice] = "Ce voyage est validé."
          MainMailer.livret_ready_email(@trip.user, @trip).deliver
        else
          flash[:alert] = "Les changements n'ont pu être enregistrés."
        end
      else
        flash[:alert] = "Vous n'êtes pas authorisé à effectuer cette opération."
      end

    when 'done'

    else
      flash[:alert] = "Error: Got an invalid status : #{params[:status]}"
    end
    redirect_back(fallback_location: root_url)
  end

  private
    def set_trip_and_gestion
      @trip    = Trip.find(params[:trip_id])
      @gestion = @trip.gestion
    end

end
