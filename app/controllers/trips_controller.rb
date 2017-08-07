class TripsController < ApplicationController
  before_action :authenticate_user!,  except: [:infos]
  before_action :set_trip,            only: [:show, :edit, :update, :destroy]
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

  def infos
  end

  # GET /trips/new
  def new
    @trip = current_user.trips.build
    @trip.build_budget
    @trip.build_rythme
    @trip.build_style
    @trip.build_gestion
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = current_user.trips.build(trip_params)
    @trip.build_gestion
    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Félicitations ! Un nouveau voyage a été crée.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html {
          flash.now[:alert] = "Votre voyage n'a pas pu être enregistré : pensez à donner un nom et à indiquer le nombre d'adultes pour ce voyage."
          render action: "new"
        }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to @trip, notice: 'Changements enregistrés' }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html {
          flash.now[:alert] = "Votre voyage n'a pas pu être enregistré : pensez à donner un nom et à indiquer le nombre d'adultes pour ce voyage."
          render action: "edit"
          }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Ce voyage a été supprimé.' }
      format.json { head :no_content }
    end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def can_edit_it?
      if @trip.gestion.status != 'new'
        redirect_to root_url
        flash[:alert] = 'Vous ne pouvez pas modifier ce voyage.'
      end
    end
    def can_delete_it?
      unless ['new', 'pending', 'approved'].include? @trip.gestion.status
        redirect_to root_url
        flash[:alert] = 'Vous ne pouvez pas supprimer ce voyage.'
      end
    end
    def set_trip
      if current_user.admin
        @trip = Trip.find(params[:id])
      else
        @trip = current_user.trips.find(params[:id])
      end
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:id, :name, :price, :status, :comment, :date, :adults, :kids,
                                    budget_attributes: [:id, :value],
                                    rythme_attributes: [:id, :value, :first, :offtrack],
                                    style_attributes:  [:id, :culture, :nature, :sport, :food, :shopping, :kid]
                                    )
    end
end
