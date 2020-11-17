class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]
  before_action :set_owner, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :set_subscription, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  # GET /shops
  # GET /shops.json
  def index
    @shops = Shop.all
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
  end

  # GET /shops/new
  def new
    @shop = Shop.new
  end

  # GET /shops/1/edit
  def edit
  end

  # POST /shops
  # POST /shops.json
  def create
    @shop = Shop.new(shop_params)

    respond_to do |format|
      if @shop.save
        format.html { redirect_to new_owner_shop_subscription_url(@owner, @shop), notice: 'Shop was successfully created.' }
        format.json { render :index, status: :created, location: @shop }

        Subscription.update(
          subscription_detail: @shop.store_information,
          owner_id: @shop.owner_id,
          shop_id: @shop.id
        )
      else
        format.html { render :new }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1
  # PATCH/PUT /shops/1.json
  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to new_owner_shop_subscription_url(@owner, @shop), notice: 'Shop was successfully updated.' }
        format.json { render :index, status: :ok, location: @shop }
      else
        format.html { render :edit }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to owner_shops_url, notice: 'Shop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    def set_owner
      @owner = Owner.find(params[:owner_id])
    end

    def set_subscription
      @subscription = Subscription.find_by(params[:subscription_id])
    end

    # Only allow a list of trusted parameters through.
    def shop_params
      params.require(:shop).permit(:category_name, :monthly_fee, :phone_number, :store_information, :payee, :line_id, :address, :owner_id)
    end
end
