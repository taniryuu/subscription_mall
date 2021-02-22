class PrivateStoresController < ApplicationController
  before_action :set_private_store, only: [:show, :edit, :update, :destroy, :edit_recommend, :update_recommend]
  before_action :set_owner, only: [:index, :new, :create, :show, :edit, :update, :destroy, :edit_recommend, :update_recommend]
  before_action :payment_check, only: %i(show)
  # before_action :set_shop, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  # GET /private_stores
  # GET /private_stores.json
  def index
    @private_stores = @owner.private_stores
  end

  def list
    @private_stores = PrivateStore.includes(:owner)
  end

  def shop_case
    @private_stores = PrivateStore.includes(:owner)
  end

  def edit_recommend
    
  end

  def update_recommend
    if @private_store.update(recommend_params)
      if @private_store.recommend == true
        @private_store.recommend = true
      flash[:success] = "#{@owner.name}様をおすすめ店舗に加えました。"
      elsif @private_store.recommend == false
        @private_store.recommend = false
      end
    redirect_to recommend_categories_url
    end
  end

  # GET /private_stores/1
  # GET /private_stores/1.json
  def show
    gon.private_stores = @private_store
    @reviews = Review.all
    @ticket = Ticket.includes(:user)
  end

  def plan_description
  end

  # GET /private_stores/new
  def new
    @private_store = PrivateStore.new
    @private_store.images.build
  end

  # GET /private_stores/1/edit
  def edit
  end

  # POST /private_stores
  # POST /private_stores.json
  def create
    @private_store = PrivateStore.new(private_store_params)
    respond_to do |format|
      if @private_store.save
	if params[:private_store][:qr_image]
          File.binwrite("public/private_store_images/#{@private_store.id}.PNG", params[:private_store][:qr_image].read)
          @private_store.update(qr_image: "#{@private_store.id}.PNG" )
        else
          flash[:danger] = "QRコードを指定できませんでした。"
        end
        format.html { redirect_to owner_private_stores_url(@private_store, id: @owner.id, owner_id: @owner.id), notice: 'サブスクショップを開設しました' }
        format.json { render :show, status: :created, location: @private_store }
      else
        format.html { render :new }
        format.json { render json: @private_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /private_stores/1
  # PATCH/PUT /private_stores/1.json
  def update
    respond_to do |format|
      if @private_store.update(private_store_params)
	if params[:private_store][:qr_image]
          File.binwrite("public/private_store_images/#{@private_store.id}.PNG", params[:private_store][:qr_image].read)
          @private_store.update(qr_image: "#{@private_store.id}.PNG" )
        else
          flash[:danger] = "QRコードを指定できませんでした。"
        end
        format.html { redirect_to owner_private_store_url(@private_store, owner_id: @owner.id), notice: 'サブスクショップを更新しました' }
        format.json { render :show, status: :ok, location: @private_store }
      else
        format.html { render :edit }
        format.json { render json: @private_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /private_stores/1
  # DELETE /private_stores/1.json
  def destroy
    @private_store.destroy
    respond_to do |format|
      format.html { redirect_to owner_private_stores_url(@private_store, owner_id: @owner.id), notice: 'サブスクショップを削除しました' }
      format.json { head :no_content }
    end
  end

  def show_sample
  end

  def company_profile
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_private_store
      @private_store = PrivateStore.find(params[:id])
    end

    def set_owner
      @owner = Owner.find(params[:owner_id])
    end

    # def set_shop
    #   @shop = Shop.find(params[:shop_id])
    # end

    # Only allow a list of trusted parameters through.
    def private_store_params
      params.require(:private_store).permit(:name, :title, :address, :shop_introduction, :detail, :qr_image, :image_private_store, :image_private_store2, :image_private_store3, :image_private_store4, :image_private_store5, :sub_image, :sub_image2, :sub_image3, :sub_image4, :sub_image5, :sub_image6, :sub_image7, :sub_image8, :sub_image9, :sub_image10, :sub_image11, :sub_image12, :image_private_store_id, :private_store_detail, :category_name, :category_genre, :price, :owner_id, images_attributes: [:image])
    end

    def recommend_params
      params.require(:private_store).permit(:recommend, :owner_id)
    end

    def map_params
      params.require(:map).permit(:address, :distance, :time)
    end

    def payment_check
      @payment = current_user.user_plans.find_by(private_store_id: params[:id]) if user_signed_in?
      if @payment.present?
        @str = Stripe::Checkout::Session.retrieve(@payment.customer_id)
        @aa = Stripe::PrivateStore.retrieve(@str.private_store)
      end
    end
end
