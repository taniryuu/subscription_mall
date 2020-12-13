class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  before_action :set_owner, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :set_shop, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = @owner.subscriptions
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
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
        format.html { redirect_to setup_subscriptions_url(@subscription, id: @owner.id, owner_id: @owner.id, shop_id: @shop.id), notice: 'Subscription was successfully created.' }
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
        format.html { redirect_to owner_shop_subscription_url(@subscription, owner_id: @owner.id, shop_id: @shop.id), notice: 'Subscription was successfully updated.' }
        format.json { render :show, status: :ok, location: @subscription }

        Category.update(
          name: @subscription.category_name,
          owner_id: @subscription.owner_id
        )
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
      format.html { redirect_to owner_shop_subscriptions_url(@subscription, owner_id: @owner.id, shop_id: @shop.id), notice: 'Subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def setup
    # @subscription = @owner.subscriptions.find_by(params[:id])
    @owner = Owner.find(params[:id])

    @plan1 = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: @owner.email,
      line_items: [{
        price_data: {
          currency: 'jpy',
          product: 'prod_IQEjlDvOeRJkqv',
          unit_amount: 1980,
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
      customer_email: @owner.email,
      line_items: [{
        price_data: {
          currency: 'jpy',
          product: 'prod_IQEjlDvOeRJkqv',
          unit_amount: 4980,
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
      customer_email: @owner.email,
      line_items: [{
        price_data: {
          currency: 'jpy',
          product: 'prod_IQEjlDvOeRJkqv',
          unit_amount: 19800,
          recurring: {interval: "month"}
        },
        quantity: 1,
      }],
      mode: 'subscription',
      success_url: success_url,
      cancel_url: cancel_url,
    )

end


  def cancel
  end

  def success
  end

  def show_sample
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def set_owner
      @owner = Owner.find(params[:owner_id])
    end

    def set_shop
      @shop = Shop.find(params[:shop_id])
    end

    # Only allow a list of trusted parameters through.
    def subscription_params
      params.require(:subscription).permit(:name, :title, :detail, :image_subscription, :image_subscription2, :image_subscription3, :image_subscription4, :image_subscription_id, :subscription_detail, :category_name, :category_genre, :owner_id, :shop_id, images_attributes: [:image])
    end
end
