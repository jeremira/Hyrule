class DaysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip,               only: [:show, :new, :edit, :create, :update, :destroy]
  before_action :set_day,                only: [:show, :edit, :update, :destroy]
  before_action :trip_must_be_editable,  only: [:new, :edit, :create, :update, :destroy]
  before_action :format_theme_collection, only: [:new, :edit, :create, :update]

  # GET /days/1
  # GET /days/1.json
  def show
    @images = @day.theme.gallery.split(' ')
    @images.map! do |img|
      ActionController::Base.helpers.asset_url(img)
    end
  end

  # GET /days/new
  def new
    @day  = @trip.days.build
    @day.build_lunch
    @day.build_dinner
  end

  # GET /days/1/edit
  def edit
  end

  # POST /days
  # POST /days.json
  def create
    @day = @trip.days.build(day_params)
    respond_to do |format|
      if @day.save
        format.html { redirect_to [@trip, @day], notice: 'Une journée a été ajoutée à votre séjour.' }
        format.json { render :show, status: :created, location: @day }
      else
        format.html {
          flash.now[:alert] = "Une erreur s'est produite. Votre journée n'a pas été enregistrée"
          render :new
        }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /days/1
  # PATCH/PUT /days/1.json
  def update
    respond_to do |format|
      if @day.update(day_params)
        @day.save
        format.html { redirect_to @trip, notice: 'Changements enregistrés.' }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html {
          flash.now[:alert] = "Les changements n'ont pas pu être enregistrés."
          render :edit
        }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /days/1
  # DELETE /days/1.json
  def destroy
    @day.destroy
    respond_to do |format|
      format.html { redirect_to trip_url(@trip), notice: 'Cette journée a bien été supprimée.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_day
      @day = @trip.days.find(params[:id])
    end

    def set_trip
      if current_user.admin
        @trip = Trip.find(params[:trip_id])
      else
        @trip = current_user.trips.find(params[:trip_id])
      end
    end

    def trip_must_be_editable
      unless @trip.gestion.status == 'new'
        unless current_user.admin
          redirect_to trips_url
          flash[:alert] = "Vous ne pouvez pas modifier ce voyage."
        end
      end
    end

    def format_theme_collection
      @themes = Theme.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def day_params
      params.require(:day).permit(:date, :comment, :theme_id, :guide,
                                lunch_attributes:  [:id, :todo, :style],
                                dinner_attributes: [:id, :todo, :style],
                                )
    end
end
