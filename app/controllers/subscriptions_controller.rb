class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:update, :show, :edit, :update, :destroy, :edit_recommend, :update_recommend]
  before_action :set_owner, only: [:index, :new, :create, :show, :edit, :update, :destroy, :owner_subscriptions, :edit_recommend, :update_recommend, :subscription_confirm, :subscription_judging]
  before_action :create, only: [:subscription_judging]
  before_action :set_category, only: [:edit, :update, :destroy, :edit_recommend, :update_recommend]
  before_action :payment_check, only: %i(show)
  before_action :sub_current_owner, only: %i(edit index)
  # before_action :set_owner_subscription, only: %i()

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = @owner.subscriptions
    @subscriptions_count = @owner.subscriptions.count
  end

  def owner_subscriptions
    @subscriptions = @owner.subscriptions
  end

  def subscription_all_shop
    @subscriptions = Subscription.where(admin_last_check: "加盟承認審査済み")
    @subscriptions_count = Subscription.where(admin_last_check: "加盟承認審査済み").count
  end

  def show
    gon.subscriptions = @subscription
    @sub_images = @subscription.images
    @reviews = @subscription.reviews.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
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

  # GET /subscriptions/1
  # GET /subscriptions/1.json

  def plan_description
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
    # @subscription.images.build
    @categories = Category.all
  end

  #審査申込確認画面
  def subscription_confirm
    if @subscription = Subscription.new(subscription_params)
      render :subscription_confirm
    else
     render :new
    end
  end

  #審査申込完了画面
  def subscription_judging
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @categories = Category.all
    @subscription = Subscription.new(subscription_params)
    respond_to do |format|
      if @subscription.save
	      @subscription.update(ordinal: Subscription.count)
        SubscriptionMailer.with(subscription: @subscription, new: "true").notification_email.deliver_now
        format.html { render :subscription_judging, notice: '加盟店サブスクショップの審査申請しました' }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /subscriptions/1/edit
  def edit
    @categories = Category.all
    @subscription.images.build
    @instablog = Instablog.new
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    @images = Image.where.not(id: nil)
    @categories = Category.all
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to owner_subscriptions_url(owner_id: @owner.id), notice: 'サブスクショップを更新しました' }
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
    
    targets = Subscription.where(ordinal: (@subscription.ordinal + 1)..Float::INFINITY)

    targets.each do |target|
      target.update(ordinal: target.ordinal - 1)
    end
	  
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to owner_subscriptions_url(owner_id: @owner.id), notice: 'サブスクショップを削除しました' }
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
                                              :detail,
                                              :qr_image,
                                              :image_subscription,
                                              :sub_image,
                                              :sub_image2,
                                              :sub_image3,
                                              :sub_image4,
                                              :sub_image5,
                                              :sub_image6,
                                              :sub_image7,
                                              :sub_image8,
                                              :sub_image9,
                                              :admin_subscription_check,
                                              :subscription_detail,
                                              :price,
                                              :site,
                                              :situation,
                                              :category_id,
                                              :owner_id,
                                              :trial,
                                              # { :images_attributes=> [:subscription_id, :subscription_image]},
                                              # { :category_ids=> [] }
                                            )
      end

      def judging_params
        params.require(:subscription).permit(:name, :owner_id, :site, :admin_subscription_check)
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

      # 現在ログインしている経営者を許可します。
      def sub_current_owner
        @owner = Owner.find(params[:owner_id]) if @owner.blank?
        unless current_owner?(@owner) or current_admin.present?
          redirect_to owner_subscriptions_url(current_owner), notice: '他の経営者様のページへ移動できません。'
        end
      end
      # 現在ログインしている経営者を許可します。
      def set_owner_subscription
        @owner = Owner.find(params[:owner_id])
        unless @owner.subscriptions.find_by(id: params[:id])
          flash[:danger] = "権限がありません。"
          redirect_to owner_subscriptions_url @owner, notice: '権限がありません！'
        end
      end

end

