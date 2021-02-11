class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy, :user_plans, :confirm]
  before_action :set_owner, only: [:index, :new, :create, :show, :edit, :update, :destroy, :user_plans]
  before_action :payment_check, only: :show
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

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    gon.subscriptions = @subscription
    @reviews = Review.all
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

  #経営者よう決済
  # def setup
  #   # @subscription = @owner.subscriptions.find_by(params[:id])
  #   @owner = Owner.find(params[:id])

  #   @plan1 = Stripe::Checkout::Session.create(
  #     payment_method_types: ['card'],
  #     customer_email: @owner.email,
  #     line_items: [{
  #       price_data: {
  #         currency: 'jpy',
  #         product: 'prod_IQEjlDvOeRJkqv',
  #         unit_amount: 1980,
  #         recurring: {interval: "month"}
  #       },
  #       quantity: 1,
  #     }],
  #     mode: 'subscription',
  #     success_url: success_url,
  #     cancel_url: cancel_url,
  #   )

  #   @plan2 = Stripe::Checkout::Session.create(
  #     payment_method_types: ['card'],
  #     customer_email: @owner.email,
  #     line_items: [{
  #       price_data: {
  #         currency: 'jpy',
  #         product: 'prod_IQEjlDvOeRJkqv',
  #         unit_amount: 4980,
  #         recurring: {interval: "month"}
  #       },
  #       quantity: 1,
  #     }],
  #     mode: 'subscription',
  #     success_url: success_url,
  #     cancel_url: cancel_url,
  #   )

  #   @plan3 = Stripe::Checkout::Session.create(
  #     payment_method_types: ['card'],
  #     customer_email: @owner.email,
  #     line_items: [{
  #       price_data: {
  #         currency: 'jpy',
  #         product: 'prod_IQEjlDvOeRJkqv',
  #         unit_amount: 19800,
  #         recurring: {interval: "month"}
  #       },
  #       quantity: 1,
  #     }],
  #     mode: 'subscription',
  #     success_url: success_url,
  #     cancel_url: cancel_url,
  #   )

  # end


  def user_plans
  end

  def confirm
    current_user.update!(session_id: params[:session].to_i)
    @price = current_user.session_id

    # @plan = Stripe::Checkout::Session.create(
    #   payment_method_types: ['card'],
    #   customer_email: current_user.email,
    #   line_items: [{
    #     price_data: {
    #       currency: 'jpy',
    #       product: 'prod_Itdb3ZOVEaX3iU',
    #       unit_amount: @price,
    #       recurring: {interval: "month"}
    #     },
    #     quantity: 1,
    #   }],
    #   mode: 'subscription',
    #   success_url: success_url,
    #   cancel_url: cancel_url,
    # )

    @plan = Stripe::Checkout::Session.create(
      success_url: success_url,
      cancel_url: cancel_url,
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
        price: params[:session],
        quantity: 1},
      ],
      mode: 'subscription',
    )

    current_user.update!(session_id: @plan.id, subscription_id: @subscription.id)
  end


  def cancel
    current_user.update!(session_id: "", subscription_id: "")
  end

  def success
    UserPlan.create!(
      customer_id: current_user.session_id,
      user_id: current_user.id,
      subscription_id: current_user.subscription_id
    )
    current_user.update!(session_id: "", subscription_id: "")
  end

  def show_sample
  end

  def payment_check
    payment = current_user.user_plans.find_by(subscription_id: params[:id])
    @str = Stripe::Checkout::Session.retrieve(payment.customer_id) if payment.present?
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

    def map_params
      params.require(:map).permit(:address, :distance, :time)
    end
end
