class SuportsController < ApplicationController
  before_action :set_suport, only: [:show, :edit, :update, :destroy]

  # GET /suports
  # GET /suports.json
  def index
    @suports = Suport.all
  end

  # GET /suports/1
  # GET /suports/1.json
  def show
  end

  # GET /suports/new
  def new
    @suport = Suport.new
  end

  # GET /suports/1/edit
  def edit
  end

  # POST /suports
  # POST /suports.json
  def create
    @suport = Suport.new(suport_params)

    respond_to do |format|
      if @suport.save
        format.html { redirect_to @suport, notice: 'Suport was successfully created.' }
        format.json { render :show, status: :created, location: @suport }
      else
        format.html { render :new }
        format.json { render json: @suport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suports/1
  # PATCH/PUT /suports/1.json
  def update
    respond_to do |format|
      if @suport.update(suport_params)
        format.html { redirect_to @suport, notice: 'Suport was successfully updated.' }
        format.json { render :show, status: :ok, location: @suport }
      else
        format.html { render :edit }
        format.json { render json: @suport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suports/1
  # DELETE /suports/1.json
  def destroy
    @suport.destroy
    respond_to do |format|
      format.html { redirect_to suports_url, notice: 'Suport was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suport
      @suport = Suport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def suport_params
      params.require(:suport).permit(:name, :email, :subject, :message, :user_id, :owner_id)
    end
end
