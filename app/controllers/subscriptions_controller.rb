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
