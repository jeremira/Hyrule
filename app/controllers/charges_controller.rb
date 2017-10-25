class ChargesController < ApplicationController

  def new
  end

  def create
    # Amount in cents
    @trip = Trip.find(params[:trip_id])
    @amount = params[:amount]
    #TODO move this mess in a model
    begin
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

end
