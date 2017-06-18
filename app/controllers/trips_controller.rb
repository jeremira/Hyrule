class TripsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip,            only: [:show, :edit, :update, :destroy, :book]
  before_action :can_edit_it?  ,      only: [:edit, :update]
  before_action :can_delete_it?,      only: [:destroy]
  # GET /trips
  # GET /trips.json
  def index
      @trips = current_user.trips
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @days = @trip.days
  end

  # GET /trips/new
  def new
    @trip = current_user.trips.build
    @trip.build_budget
    @trip.build_rythme
    @trip.build_style
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = current_user.trips.build(trip_params)
    @trip.status = 0
    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /trips/1/book
  # GET /trips/1.book.json
  def book
    set_trip_status_to params[:status]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def can_edit_it?
      if @trip.status != 0
        redirect_to root_url
        flash[:alert] = 'Cant edit a booked trip.'
      end
    end
    def can_delete_it?
      if @trip.status != 0 || @trip.status != 1
        redirect_to root_url
        flash[:alert] = 'Cant delete a booked trip'
      end
    end
    def set_trip
      @trip = Trip.find(params[:id])
    end

    def set_trip_status_to status
      case status
        when :construction

        when 'booking'
          if current_user == @trip.user
            @trip.status = 1
            if @trip.save
              flash[:notice] = "Thank you. Trip is now reviewed by our team."
              redirect_to @trip
            end
          else
            flash[:alert] = "You're not allowed to modify this trip."
            redirect_to root_url
          end
        when 'approved'
          if current_user.admin
            @trip.status = 2
            if @trip.save
              flash[:notice] = "Trip id:#{@trip.id} was approved !"
              redirect_to setup_index_path
            else
              flash[:alert] = "Could not save change."
              redirect_to setup_index_path
            end
          else
            flash[:alert] = "Only admin here"
            redirect_to root_url
          end
        when :payed

        when :confirmed

        when :done

        else
          flash[:alert] = "Status #{status} not implemented."
          redirect_to root_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:id, :name, :price, :description, :status, :comment, :date, :adults, :kids,
                                    budget_attributes: [:id, :value, :comment],
                                    rythme_attributes: [:id, :value, :comment, :walking, :transport],
                                    style_attributes:  [:id, :culture, :nature, :sport, :food, :shopping, :kid, :comment]
                                    )
    end
end
