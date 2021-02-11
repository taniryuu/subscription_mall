class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy, :edit_recommend, :update_recommend]
  before_action :set_owner, only: [:index, :new, :create, :show, :edit, :update, :destroy, :edit_recommend, :update_recommend]
  # before_action :set_shop, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = @owner.subscriptions
  end

  def list
    @subscriptions = Subscription.includes(:owner)
  end

  def shop_case
    @subscriptions = Subscription.includes(:owner)
  end

  def edit_recommend
    
  end

  def update_recommend
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
  def show
    gon.subscriptions = @subscription
    @reviews = Review.all
    @ticket = Ticket.includes(:user)
  end

  def plan_description
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
    @subscription.images.build
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)
    respond_to do |format|
      if @subscription.save
        format.html { redirect_to owner_subscriptions_url(@subscription, id: @owner.id, owner_id: @owner.id), notice: 'サブスクショップを開設しました' }
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
      format.html { redirect_to owner_subscriptions_url(@subscription, owner_id: @owner.id), notice: 'サブスクショップを削除しました' }
      format.json { head :no_content }
    end
  end



  def user_plans
    @user = User.find(params[:id])

    @plan1 = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: @user.email,
      line_items: [{
        price_data: {
          currency: 'jpy',
          product: 'prod_Itdb3ZOVEaX3iU',
          unit_amount: 3000,
          recurring: {interval: "month"}
        },
        quantity: 1,
      }],
      mode: 'subscription',
      success_url: success_url,
      cancel_url: cancel_url,
    )

    @plan2 = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: @user.email,
      line_items: [{
        price_data: {
          currency: 'jpy',
          product: 'prod_Itdb3ZOVEaX3iU',
          unit_amount: 9000,
          recurring: {interval: "month"}
        },
        quantity: 1,
      }],
      mode: 'subscription',
      success_url: success_url,
      cancel_url: cancel_url,
    )

    @plan3 = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: @user.email,
      line_items: [{
        price_data: {
          currency: 'jpy',
          product: 'prod_Itdb3ZOVEaX3iU',
          unit_amount: 11000,
          recurring: {interval: "month"}
        },
        quantity: 1,
      }],
      mode: 'subscription',
      success_url: success_url,
      cancel_url: cancel_url,
    )

    @plan4 = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: @user.email,
      line_items: [{
        price_data: {
          currency: 'jpy',
          product: 'prod_Itdb3ZOVEaX3iU',
          unit_amount: 18000,
          recurring: {interval: "month"}
        },
        quantity: 1,
      }],
      mode: 'subscription',
      success_url: success_url,
      cancel_url: cancel_url,
    )

    @plan5 = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: @user.email,
      line_items: [{
        price_data: {
          currency: 'jpy',
          product: 'prod_Itdb3ZOVEaX3iU',
          unit_amount: 25000,
          recurring: {interval: "month"}
        },
        quantity: 1,
      }],
      mode: 'subscription',
      success_url: success_url,
      cancel_url: cancel_url,
    )

    @plan6 = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: @user.email,
      line_items: [{
        price_data: {
          currency: 'jpy',
          product: 'prod_Itdb3ZOVEaX3iU',
          unit_amount: 50000,
          recurring: {interval: "month"}
        },
        quantity: 1,
      }],
      mode: 'subscription',
      success_url: success_url,
      cancel_url: cancel_url,
    )

    @plan7 = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: @user.email,
      line_items: [{
        price_data: {
          currency: 'jpy',
          product: 'prod_Itdb3ZOVEaX3iU',
          unit_amount: 100000,
          recurring: {interval: "month"}
        },
        quantity: 1,
      }],
      mode: 'subscription',
      success_url: success_url,
      cancel_url: cancel_url,
    )

    @user.update(session_id: "true")

  end

  def cancel
  end

  def success
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

    # def set_shop
    #   @shop = Shop.find(params[:shop_id])
    # end

    # Only allow a list of trusted parameters through.
    def subscription_params
      params.require(:subscription).permit(:name, :title, :address, :shop_introduction, :detail, :qr_image, :image_subscription, :image_subscription2, :image_subscription3, :image_subscription4, :image_subscription5, :sub_image, :sub_image2, :sub_image3, :sub_image4, :sub_image5, :sub_image6, :sub_image7, :sub_image8, :sub_image9, :sub_image10, :sub_image11, :sub_image12, :image_subscription_id, :subscription_detail, :category_name, :category_genre, :price, :owner_id, images_attributes: [:image])
    end

    def recommend_params
      params.require(:subscription).permit(:recommend, :owner_id)
    end

    def map_params
      params.require(:map).permit(:address, :distance, :time)
    end
end
