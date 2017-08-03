class ThemesController < ApplicationController
  before_action :only_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_theme, only: [:show, :edit, :update, :destroy]

  # GET /themes
  # GET /themes.json
  def index
    @themes = Theme.all
    @tokyo_themes = Theme.where(style: 'tokyo')
    @around_theme = Theme.where(style: 'around')
    @theme_themes = Theme.where(style: 'theme')
  end

  # GET /themes/1
  # GET /themes/1.json
  def show
  end

  # GET /themes/new
  def new
    @theme = Theme.new
  end

  # GET /themes/1/edit
  def edit
  end

  def commercial
    #Send a random theme Jsonified for commercial banner
    #{"name":"balbalba","descr":"Blablabla","image":"url(/assets/019-2161216d4qsd31qs3.jpg)"}
    @random_theme = Theme.all.sample
    @theme = {}
    @theme['name'] = @random_theme.name
    @theme['descr'] = @random_theme.descr
    @theme['image'] = "url("+ActionController::Base.helpers.asset_url(@random_theme.gallery.split(" ").sample)+")"
    respond_to do |format|
      format.json { render json: @theme }
    end
  end

  # POST /themes
  # POST /themes.json
  def create
    @theme = Theme.new(theme_params)

    respond_to do |format|
      if @theme.save
        format.html { redirect_to @theme, notice: 'Theme was successfully created.' }
        format.json { render :show, status: :created, location: @theme }
      else
        format.html { render :new }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /themes/1
  # PATCH/PUT /themes/1.json
  def update
    respond_to do |format|
      if @theme.update(theme_params)
        format.html { redirect_to @theme, notice: 'Theme was successfully updated.' }
        format.json { render :show, status: :ok, location: @theme }
      else
        format.html { render :edit }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /themes/1
  # DELETE /themes/1.json
  def destroy
    @theme.destroy
    respond_to do |format|
      format.html { redirect_to themes_url, notice: 'Theme was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      @theme = Theme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def theme_params
      params.require(:theme).permit(:name, :descr, :image, :style, :gallery)
    end
end
