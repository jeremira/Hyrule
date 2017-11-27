class GestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip_and_gestion

  def charge
    begin
      @gestion.process_stripe_charge(params[:amount].to_i, params[:stripeEmail], params[:stripeToken])
      flash[:notice] = "Votre paiement a bien été pris en compte. "
    rescue Stripe::CardError => e
      flash[:warning] = "Problème de paiement :" + e.message
    rescue
      flash[:warning] = "Quelque chose ne va pas..."
    else
      #stripe automatic email only atm
      #MainMailer.payed_email(@trip.user, @trip).deliver
      flash[:notice] = "Votre voyage est payé !"
    end
    redirect_to @trip
  end

  def update
    #Admin can update any trip to any status
    if current_user.admin
      new_status = params[:status]
      @gestion.update_status(new_status)
      if @gestion.save
        MainMailer.ready_email(@trip.user, @trip).deliver          if @gestion.status == 'approved'
        MainMailer.livret_ready_email(@trip.user, @trip).deliver   if @gestion.status == 'final'
        flash[:notice] = "Trip status updated to #{new_status}"
      else
        flash[:alert] = "Trip status NOT updated to #{new_status}"
      end
    #Non-admin user can only go : New => Approved status
    elsif @gestion.is_bookable?
      @gestion.book_trip
      if @gestion.save
        MainMailer.ready_email(@trip.user, @trip).deliver
        flash[:notice] = "Merci pour votre réservation !"
      else
        flash[:alert] = "Votre voyage n'a pas pu être réservé."
      end
    #Trip cant be booked/updated
    else
      flash[:alert] = "Vous devez rajouter au moins une journée à votre séjour."
    end
    redirect_back(fallback_location: root_url)
  end

  def old_charge
    # Amount in cents
    @amount = params[:amount]
    #TODO move this mess in a model
    begin
    #@trip.process_stripe_charge params[:amount], params[:stripeEmail], params[:stripeToken]

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Séjour Tokyhop.fun',
      :currency    => 'eur'
    )

    flash[:notice] = "Votre paiement a bien été pris en compte. "
    rescue Stripe::CardError => e
      flash[:warning] = "Problème de paiement :" + e.message
    rescue
      flash[:warning] = "Quelque chose ne va pas..."
    else
      #refactor to a redirect to gestion update # payed
      @trip.gestion.update_attributes(:status => :payed,
                                      :token => charge.id,
                                      :payment_date => Time.now,
                                      :amount_payed => @amount)
      #stripe automatic email only atm
      #MainMailer.payed_email(@trip.user, @trip).deliver
      flash[:notice] = "Votre voyage est payé !"
    ensure
      redirect_to trip_path(@trip)
    end
  end
#deprecated old version of gestion#update, no more in use, for reference
  def old_update
    case params[:status]
    when 'new'

    when 'pending'
      if current_user == @trip.user && @gestion.status == 'new'
        if @trip.days.length > 0
          @gestion.status = 'pending'
          if @gestion.save
            flash[:notice] = "Merci de votre réservation. Nos équipes vont prendre en charge votre demande."
            MainMailer.booking_email(@trip.user, @trip).deliver
          else
            flash[:alert] = "Les changements n'ont pas pu être enregistrés."
          end
        else
          flash[:alert] = "Vous ne pouvez pas réserver un voyage sans journée."
        end
      else
        flash[:alert] = "Désolé, vous ne pouvez pas modifier ce voyage."
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
      flash[:alert] = "Une erreur s'est produite"
    end
    redirect_back(fallback_location: root_url)
  end

  private
    def set_trip_and_gestion
      if current_user.admin
        @trip = Trip.find(params[:trip_id])
      else
        @trip = current_user.trips.find(params[:trip_id])
      end
        @gestion = @trip.gestion
    end

end
