class LivretsController < ApplicationController

  def index
    @livrets = Livret.all
  end

  def show
    @livret = Livret.find(params[:id])
    @trip = @livret.trip
  end

  def new
    @trip = Trip.find(params[:trip_id])
    @livret = @trip.build_livret
  end
    # GET /trips/1/edit
  def edit
    @livret = Livret.find(params[:id])
  end

  def create
    @trip = Trip.find(params[:livret][:trip_id])
    @livret = @trip.build_livret(livret_params)
    respond_to do |format|
      if @livret.save
        format.html { redirect_to @livret, notice: 'Livret created succesfully !' }
        format.json { render :show, status: :created, location: @livret }
      else
        format.html {
          flash.now[:alert] = "Could not create Livret entry !"
          render action: "new"
        }
        format.json { render json: @livret.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @livret = Livret.find(params[:id])
    respond_to do |format|
      if @livret.update(livret_params)
        format.html { redirect_to @livret, notice: 'Changements enregistrés' }
        format.json { render :show, status: :ok, location: @livret }
      else
        format.html {
          flash.now[:alert] = "Could not update Livret entry !"
          render action: "edit"
        }
        format.json { render json: @livret.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @livret = Livret.find(params[:id])
    @livret.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Livret entry deleted !' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
    def livret_params
      params.require(:livret).permit(:id, :trip_id, :htmlbook)
    end

end
