class ChargesController < ApplicationController

  def new
  end

  def create
    # Amount in cents
    @trip = Trip.find(params[:trip_id])
    @amount = 500
    #TODO move this mess in a model
    begin
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    flash[:notice] = "Card charged successfully ! "
    rescue Stripe::CardError => e
      flash[:warning] = "This card is on fire ! " + e.message
    rescue
      flash[:warning] = "Something went wrong ?"
    else
      @trip.gestion.update(status: :payed)
      flash[:notice] = "Card charge success !"
    ensure
      redirect_to trip_path(@trip)
    end
  end

end
