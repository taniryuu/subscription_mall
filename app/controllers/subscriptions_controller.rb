class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:index, :update, :show, :edit, :update, :destroy, :edit_recommend, :update_recommend, :edit_favorite, :update_favorite]
  before_action :set_owner, only: [:index, :new, :create, :show, :edit, :update, :destroy, :owner_subscriptions, :edit_recommend, :update_recommend]
  # before_action :set_user, only: [:favorite, :edit_favorite, :update_favorite]
  before_action :set_category, only: [:edit, :update, :destroy, :edit_recommend, :update_recommend]
  before_action :payment_check, only: %i(show)

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = @owner.subscriptions
  end

  def owner_subscriptions
    @subscriptions = @owner.subscriptions
    @subscription = Subscription.find(params[:id])
  end

  def show
    gon.subscriptions = @subscription
    @reviews = Review.all
    @ticket = Ticket.includes(:user)
  end

  def like_lunch
    @subscription = Subscription.find(params[:subscription_id])
  end

  def list
    @subscriptions = Subscription.includes(:owner)
  end

  def shop_case
    @subscriptions = Subscription.includes(:owner)
  end

  def edit_recommend#おすすめ追加
  end

  def update_recommend#おすすめ追加
    if @subscription.update(recommend_params)
      if @subscription.recommend == true
        @subscription.recommend = true
      flash[:success] = "#{@owner.name}様サブスクをおすすめ店舗に加えました。"
      elsif @subscription.recommend == false
        @subscription.recommend = false
      end
    redirect_to recommend_categories_url
    end
  end

  # def favorite
  #   @subscriptions = @user.subscriptions.where(favorite: true, user_id: current_user.id)
  # end

  # def edit_favorite
  # end

  # def update_favorite
  #   if @subscription.favorite == false
  #     if @subscription.update(favorite: true, user_id: current_user.id)
  #       flash[:success] = "お気に入り店舗に加えました。"
  #     end
  #   elsif @subscription.favorite == true
  #     if @subscription.update(favorite: false, user_id: nil)
  #       flash[:success] = "お気に入り店舗に加えました。"
  #     end
  #   end
  #   redirect_to user_account_user_url(current_user)
  # end

  # GET /subscriptions/1
  # GET /subscriptions/1.json

  def plan_description
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
    @subscription.images.build
    @categories = Category.all
  end

  # GET /subscriptions/1/edit
  def edit
    @categories = Category.all
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @categories = Category.all
    @subscription = Subscription.new(subscription_params)
    respond_to do |format|
      if @subscription.save
        if params[:subscription][:qr_image]
	  File.binwrite("public/subscription_images/#{@subscription.id}0.PNG", params[:subscription][:qr_image].read)
	  @subscription.update(qr_image: "#{@subscription.id}0.PNG" )
	else
	  flash[:danger] = "QRコードを指定できませんでした。"
	end
	format.html { redirect_to owner_subscriptions_owner_subscription_url(@subscription, id: @owner.id, owner_id: @owner.id), notice: 'サブスクショップを開設しました' }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    @categories = Category.all
    respond_to do |format|
      if @subscription.update(subscription_params)
	if params[:subscription][:qr_image]
          File.binwrite("public/subscription_images/#{@subscription.id}0.PNG", params[:subscription][:qr_image].read)
          @subscription.update(qr_image: "#{@subscription.id}0.PNG" )
        else
          flash[:danger] = "QRコードを指定できませんでした。"
        end
	if params[:subscription][:image_subscription]
          File.binwrite("public/subscription_images/#{@subscription.id}1.PNG", params[:subscription][:image_subscription].read)
          @subscription.update(image_subscription: "#{@subscription.id}1.PNG" )
        else
          flash[:danger] = "image_subscriptionを指定できませんでした。"
        end
	if params[:subscription][:image_subscription2]
          File.binwrite("public/subscription_images/#{@subscription.id}2.PNG", params[:subscription][:image_subscription2].read)
          @subscription.update(image_subscription2: "#{@subscription.id}2.PNG" )
        else
          flash[:danger] = "image_subscription2を指定できませんでした。"
        end
	if params[:subscription][:image_subscription3]
          File.binwrite("public/subscription_images/#{@subscription.id}3.PNG", params[:subscription][:image_subscription3].read)
          @subscription.update(image_subscription3: "#{@subscription.id}3.PNG" )
        else
          flash[:danger] = "image_subscription3を指定できませんでした。"
        end
        if params[:subscription][:image_subscription4]
          File.binwrite("public/subscription_images/#{@subscription.id}4.PNG", params[:subscription][:image_subscription4].read)
          @subscription.update(image_subscription4: "#{@subscription.id}4.PNG" )
        else
          flash[:danger] = "image_subscription4を指定できませんでした。"
        end
        if params[:subscription][:image_subscription5]
          File.binwrite("public/subscription_images/#{@subscription.id}5.PNG", params[:subscription][:image_subscription5].read)
          @subscription.update(image_subscription5: "#{@subscription.id}5.PNG" )
        else
          flash[:danger] = "image_subscription5を指定できませんでした。"
        end
        if params[:subscription][:sub_image]
          File.binwrite("public/subscription_images/#{@subscription.id}6.PNG", params[:subscription][:sub_image].read)
          @subscription.update(image_subscription: "#{@subscription.id}6.PNG" )
        else
          flash[:danger] = "sub_imageを指定できませんでした。"
        end
        if params[:subscription][:sub_image2]
          File.binwrite("public/subscription_images/#{@subscription.id}7.PNG", params[:subscription][:sub_image2].read)
          @subscription.update(image_subscription: "#{@subscription.id}7.PNG" )
        else
          flash[:danger] = "sub_image2を指定できませんでした。"
        end
        if params[:subscription][:sub_image3]
          File.binwrite("public/subscription_images/#{@subscription.id}8.PNG", params[:subscription][:sub_image3].read)
          @subscription.update(image_subscription: "#{@subscription.id}8.PNG" )
        else
          flash[:danger] = "sub_image3を指定できませんでした。"
        end
	if params[:subscription][:sub_image4]
          File.binwrite("public/subscription_images/#{@subscription.id}9.PNG", params[:subscription][:sub_image4].read)
          @subscription.update(image_subscription: "#{@subscription.id}9.PNG" )
        else
          flash[:danger] = "sub_image8を指定できませんでした。"
        end
	if params[:subscription][:sub_image5]
          File.binwrite("public/subscription_images/#{@subscription.id}10.PNG", params[:subscription][:sub_image5].read)
          @subscription.update(image_subscription: "#{@subscription.id}10.PNG" )
        else
          flash[:danger] = "sub_image5を指定できませんでした。"
        end
	if params[:subscription][:sub_image6]
          File.binwrite("public/subscription_images/#{@subscription.id}11.PNG", params[:subscription][:sub_image6].read)
          @subscription.update(image_subscription: "#{@subscription.id}11.PNG" )
        else
          flash[:danger] = "sub_image6を指定できませんでした。"
        end
	if params[:subscription][:sub_image7]
          File.binwrite("public/subscription_images/#{@subscription.id}12.PNG", params[:subscription][:sub_image7].read)
          @subscription.update(image_subscription: "#{@subscription.id}12.PNG" )
        else
          flash[:danger] = "sub_image7を指定できませんでした。"
        end
	if params[:subscription][:sub_image8]
          File.binwrite("public/subscription_images/#{@subscription.id}13.PNG", params[:subscription][:sub_image8].read)
          @subscription.update(image_subscription: "#{@subscription.id}13.PNG" )
        else
          flash[:danger] = "sub_image8を指定できませんでした。"
        end
	if params[:subscription][:sub_image9]
          File.binwrite("public/subscription_images/#{@subscription.id}14.PNG", params[:subscription][:sub_image9].read)
          @subscription.update(image_subscription: "#{@subscription.id}14.PNG" )
        else
          flash[:danger] = "sub_image9を指定できませんでした。"
        end
	if params[:subscription][:sub_image10]
          File.binwrite("public/subscription_images/#{@subscription.id}15.PNG", params[:subscription][:sub_image10].read)
          @subscription.update(image_subscription: "#{@subscription.id}15.PNG" )
        else
          flash[:danger] = "sub_image10を指定できませんでした。"
        end
	if params[:subscription][:sub_image11]
          File.binwrite("public/subscription_images/#{@subscription.id}16.PNG", params[:subscription][:sub_image11].read)
          @subscription.update(image_subscription: "#{@subscription.id}16.PNG" )
        else
          flash[:danger] = "sub_image10を指定できませんでした。"
        end
	if params[:subscription][:sub_image12]
          File.binwrite("public/subscription_images/#{@subscription.id}17.PNG", params[:subscription][:sub_image12].read)
          @subscription.update(image_subscription: "#{@subscription.id}17.PNG" )
        else
          flash[:danger] = "sub_image12を指定できませんでした。"
        end
	format.html { redirect_to owner_subscription_url(@subscription, owner_id: @owner.id), notice: 'サブスクショップを更新しました' }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to owner_subscriptions_owner_subscription_url(@subscription, owner_id: @owner.id), notice: 'サブスクショップを削除しました' }
      format.json { head :no_content }
    end
  end

  def show_sample
  end

  def company_profile
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
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
    def subscription_params
      params.require(:subscription).permit(:name,
                                            :title, 
                                            :address, 
                                            :shop_introduction, 
                                            :detail, :qr_image, 
                                            :image_subscription, 
                                            :image_subscription2, 
                                            :image_subscription3, 
                                            :image_subscription4, 
                                            :image_subscription5, 
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
                                            :image_subscription_id, 
                                            :subscription_detail, 
                                            :price,
                                            :owner_id,
                                            { :category_ids=> [] }
                                          )
    end

    def recommend_params
      params.require(:subscription).permit(:recommend, :owner_id)
    end

    def favorite_params
      params.require(:subscription).permit(:favorite, :user_id)
    end

    def map_params
      params.require(:map).permit(:address, :distance, :time)
    end
end
