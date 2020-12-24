class MapsController < ApplicationController
  before_action :set_map, only: [:show, :edit, :update, :destroy]
  before_action :set_map, only: [:create, :show, :edit, :update, :destroy]

  # GET /maps
  # GET /maps.json
  def index
    @maps = Map.all
  end

  # GET /maps/1
  # GET /maps/1.json
  def show
  end

  # GET /maps/new
  def new
    @map = Map.new
  end

  # GET /maps/1/edit
  def edit
  end

  # POST /maps
  # POST /maps.json
  def create
    @map = Map.new(map_params)

    respond_to do |format|
      if @map.save
        format.html { redirect_to owner_subscription_url(@map, owner_id: @owner.id), notice: 'Map was successfully created.' }
        format.json { render :show, status: :created, location: @map }
      else
        format.html { render :new }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maps/1
  # PATCH/PUT /maps/1.json
  def update
    @map = Map.find(1)
    @map.update_attributes(map_params)
    respond_to do |format|
      if @map.save
        format.html { redirect_to owner_subscription_url(@map) }
      else
        format.html { render :edit }
      end
    end
  end

  def index_update
    @map = Map.find(1)
    @map.update_attributes(map_params)
    respond_to do |format|
      if @map.save
        format.html { redirect_to root_url(@map) }
      else
        format.html { render :top }
      end
    end
  end

  # DELETE /maps/1
  # DELETE /maps/1.json
  def destroy
    @map.destroy
    respond_to do |format|
      format.html { redirect_to maps_url, notice: 'Map was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_map
      @map = Map.find(1)
    end

    def set_owner
      @owner = Owner.find(params[:owner_id])
    end

    # Only allow a list of trusted parameters through.
    def map_params
      params.require(:map).permit(:address, :latitude, :longitude, :distance, :near_distance, :time, :near_time, :title, :comment)
    end
end
