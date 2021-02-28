class PrivateStoresController < ApplicationController
  before_action :set_private_store, only: [:index, :update, :show, :edit, :update, :destroy, :edit_recommend, :update_recommend, :edit_favorite, :update_favorite]
  before_action :set_owner, only: [:index, :new, :create, :show, :edit, :update, :destroy, :owner_private_stores, :edit_recommend, :update_recommend]
  # before_action :set_user, only: [:favorite, :edit_favorite, :update_favorite]
  before_action :set_category, only: [:edit, :update, :destroy, :edit_recommend, :update_recommend]
  before_action :payment_check, only: %i(show)

  # GET /private_stores
  # GET /private_stores.json
  def index
    @private_stores = @owner.private_stores
  end

  def owner_private_stores
    @private_stores = @owner.private_stores
    @private_store = PrivateStore.find(params[:id])
  end

  def show
    gon.private_stores = @private_store
    @reviews = Review.all
    @ticket = Ticket.includes(:user)
  end

  def like_lunch
    @private_store = PrivateStore.find(params[:private_store_id])
  end

  def list
    @private_stores = PrivateStore.includes(:owner)
  end

  def shop_case
    @private_stores = PrivateStore.includes(:owner)
  end

  def edit_recommend#おすすめ追加
  end

  def update_recommend#おすすめ追加
    if @private_store.update(recommend_params)
      if @private_store.recommend == true
        @private_store.recommend = true
      flash[:success] = "#{@owner.name}様サブスクをおすすめ店舗に加えました。"
      elsif @private_store.recommend == false
        @private_store.recommend = false
      end
    redirect_to recommend_categories_url
    end
  end

  # def favorite
  #   @private_stores = @user.private_stores.where(favorite: true, user_id: current_user.id)
  # end

  # def edit_favorite
  # end

  # def update_favorite
  #   if @private_store.favorite == false
  #     if @private_store.update(favorite: true, user_id: current_user.id)
  #       flash[:success] = "お気に入り店舗に加えました。"
  #     end
  #   elsif @private_store.favorite == true
  #     if @private_store.update(favorite: false, user_id: nil)
  #       flash[:success] = "お気に入り店舗に加えました。"
  #     end
  #   end
  #   redirect_to user_account_user_url(current_user)
  # end

  # GET /private_stores/1
  # GET /private_stores/1.json

  def plan_description
  end

  # GET /private_stores/new
  def new
    @private_store = PrivateStore.new
    @private_store.images.build
    @categories = Category.all
  end

  # GET /private_stores/1/edit
  def edit
    @categories = Category.all
  end

  # POST /private_stores
  # POST /private_stores.json
  def create
    @categories = Category.all
    @private_store = PrivateStore.new(private_store_params)
    respond_to do |format|
      if @private_store.save
        if params[:private_store][:qr_image]
	  File.binwrite("public/private_store_images/#{@private_store.id}0.PNG", params[:private_store][:qr_image].read)
	  @private_store.update(qr_image: "#{@private_store.id}0.PNG" )
	else
	  flash[:danger] = "QRコードを指定できませんでした。"
	end
	format.html { redirect_to owner_private_stores_owner_private_store_url(@private_store, id: @owner.id, owner_id: @owner.id), notice: 'サブスクショップを開設しました' }
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
    @categories = Category.all
    respond_to do |format|
      if @private_store.update(private_store_params)
	if params[:private_store][:qr_image]
          File.binwrite("public/private_store_images/#{@private_store.id}0.PNG", params[:private_store][:qr_image].read)
          @private_store.update(qr_image: "#{@private_store.id}0.PNG" )
        else
          flash[:danger] = "QRコードを指定できませんでした。"
        end
	if params[:private_store][:image_private_store]
          File.binwrite("public/private_store_images/#{@private_store.id}1.PNG", params[:private_store][:image_private_store].read)
          @private_store.update(image_private_store: "#{@private_store.id}1.PNG" )
        else
          flash[:danger] = "image_private_storeを指定できませんでした。"
        end
	if params[:private_store][:image_private_store2]
          File.binwrite("public/private_store_images/#{@private_store.id}2.PNG", params[:private_store][:image_private_store2].read)
          @private_store.update(image_private_store2: "#{@private_store.id}2.PNG" )
        else
          flash[:danger] = "image_private_store2を指定できませんでした。"
        end
	if params[:private_store][:image_private_store3]
          File.binwrite("public/private_store_images/#{@private_store.id}3.PNG", params[:private_store][:image_private_store3].read)
          @private_store.update(image_private_store3: "#{@private_store.id}3.PNG" )
        else
          flash[:danger] = "image_private_store3を指定できませんでした。"
        end
        if params[:private_store][:image_private_store4]
          File.binwrite("public/private_store_images/#{@private_store.id}4.PNG", params[:private_store][:image_private_store4].read)
          @private_store.update(image_private_store4: "#{@private_store.id}4.PNG" )
        else
          flash[:danger] = "image_private_store4を指定できませんでした。"
        end
        if params[:private_store][:image_private_store5]
          File.binwrite("public/private_store_images/#{@private_store.id}5.PNG", params[:private_store][:image_private_store5].read)
          @private_store.update(image_private_store5: "#{@private_store.id}5.PNG" )
        else
          flash[:danger] = "image_private_store5を指定できませんでした。"
        end
        if params[:private_store][:sub_image]
          File.binwrite("public/private_store_images/#{@private_store.id}6.PNG", params[:private_store][:sub_image].read)
          @private_store.update(image_private_store: "#{@private_store.id}6.PNG" )
        else
          flash[:danger] = "sub_imageを指定できませんでした。"
        end
        if params[:private_store][:sub_image2]
          File.binwrite("public/private_store_images/#{@private_store.id}7.PNG", params[:private_store][:sub_image2].read)
          @private_store.update(image_private_store: "#{@private_store.id}7.PNG" )
        else
          flash[:danger] = "sub_image2を指定できませんでした。"
        end
        if params[:private_store][:sub_image3]
          File.binwrite("public/private_store_images/#{@private_store.id}8.PNG", params[:private_store][:sub_image3].read)
          @private_store.update(image_private_store: "#{@private_store.id}8.PNG" )
        else
          flash[:danger] = "sub_image3を指定できませんでした。"
        end
	if params[:private_store][:sub_image4]
          File.binwrite("public/private_store_images/#{@private_store.id}9.PNG", params[:private_store][:sub_image4].read)
          @private_store.update(image_private_store: "#{@private_store.id}9.PNG" )
        else
          flash[:danger] = "sub_image8を指定できませんでした。"
        end
	if params[:private_store][:sub_image5]
          File.binwrite("public/private_store_images/#{@private_store.id}10.PNG", params[:private_store][:sub_image5].read)
          @private_store.update(image_private_store: "#{@private_store.id}10.PNG" )
        else
          flash[:danger] = "sub_image5を指定できませんでした。"
        end
	if params[:private_store][:sub_image6]
          File.binwrite("public/private_store_images/#{@private_store.id}11.PNG", params[:private_store][:sub_image6].read)
          @private_store.update(image_private_store: "#{@private_store.id}11.PNG" )
        else
          flash[:danger] = "sub_image6を指定できませんでした。"
        end
	if params[:private_store][:sub_image7]
          File.binwrite("public/private_store_images/#{@private_store.id}12.PNG", params[:private_store][:sub_image7].read)
          @private_store.update(image_private_store: "#{@private_store.id}12.PNG" )
        else
          flash[:danger] = "sub_image7を指定できませんでした。"
        end
	if params[:private_store][:sub_image8]
          File.binwrite("public/private_store_images/#{@private_store.id}13.PNG", params[:private_store][:sub_image8].read)
          @private_store.update(image_private_store: "#{@private_store.id}13.PNG" )
        else
          flash[:danger] = "sub_image8を指定できませんでした。"
        end
	if params[:private_store][:sub_image9]
          File.binwrite("public/private_store_images/#{@private_store.id}14.PNG", params[:private_store][:sub_image9].read)
          @private_store.update(image_private_store: "#{@private_store.id}14.PNG" )
        else
          flash[:danger] = "sub_image9を指定できませんでした。"
        end
	if params[:private_store][:sub_image10]
          File.binwrite("public/private_store_images/#{@private_store.id}15.PNG", params[:private_store][:sub_image10].read)
          @private_store.update(image_private_store: "#{@private_store.id}15.PNG" )
        else
          flash[:danger] = "sub_image10を指定できませんでした。"
        end
	if params[:private_store][:sub_image11]
          File.binwrite("public/private_store_images/#{@private_store.id}16.PNG", params[:private_store][:sub_image11].read)
          @private_store.update(image_private_store: "#{@private_store.id}16.PNG" )
        else
          flash[:danger] = "sub_image10を指定できませんでした。"
        end
	if params[:private_store][:sub_image12]
          File.binwrite("public/private_store_images/#{@private_store.id}17.PNG", params[:private_store][:sub_image12].read)
          @private_store.update(image_private_store: "#{@private_store.id}17.PNG" )
        else
          flash[:danger] = "sub_image12を指定できませんでした。"
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
      format.html { redirect_to owner_private_stores_owner_private_store_url(@private_store, owner_id: @owner.id), notice: 'サブスクショップを削除しました' }
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

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def private_store_params
      params.require(:private_store).permit(:name,
                                            :title, 
                                            :address, 
                                            :shop_introduction, 
                                            :detail, :qr_image, 
                                            :image_private_store, 
                                            :image_private_store2, 
                                            :image_private_store3, 
                                            :image_private_store4, 
                                            :image_private_store5, 
                                            :sub_image, 
                                            :sub_image2, 
                                            :sub_image3, 
                                            :sub_image4, 
                                            :sub_image5, 
                                            :sub_image6, 
                                            :sub_image7, 
                                            :sub_image8, 
                                            :sub_image9, 
                                            :sub_image10, 
                                            :sub_image11, 
                                            :sub_image12, 
                                            :image_private_store_id, 
                                            :private_store_detail, 
                                            :price,
                                            :owner_id,
                                            { :category_ids=> [] }
                                          )
    end

    def recommend_params
      params.require(:private_store).permit(:recommend, :owner_id)
    end

    def favorite_params
      params.require(:private_store).permit(:favorite, :user_id)
    end

    def map_params
      params.require(:map).permit(:address, :distance, :time)
    end
end
