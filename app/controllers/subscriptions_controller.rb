class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  before_action :set_owner, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :user_plans, only: [:success]
  # before_action :set_shop, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  require 'json'

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

  def success
  end

  def cancel
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
    @user = User.find(params[:id])

    @plan1 = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: @user.email,
      line_items: [{
        price_data: {
          currency: 'jpy',
          product: ENV['PRODUCT1'],
          unit_amount: 3000,
          recurring: {interval: "month"}
        },
        quantity: 1,
      }],
      mode: 'subscription',
      success_url: success_url(@user.id),
      cancel_url: cancel_url,
    )

    @plan2 = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: @user.email,
      line_items: [{
        price_data: {
          currency: 'jpy',
          product: ENV['PRODUCT2'],
          unit_amount: 9000,
          recurring: {interval: "month"}
        },
        quantity: 1,
      }],
      mode: 'subscription',
      success_url: success_url(@user.id),
      cancel_url: cancel_url,
    )

    @plan3_customer = Stripe::Customer.create({
	    email: @user.email})       

    @plan3 = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer: @plan3_customer,
      #customer_email: @user.email,
      line_items: [{
        price_data: {
          currency: 'jpy',
          product: ENV['PRODUCT3'],
          unit_amount: 11000,
          recurring: {interval: "month"}
        },
	quantity: 1,
      }],
      mode: 'subscription',
      success_url: success_url(@user.id),
      cancel_url: cancel_url,
    )

    #session_plan3 = Stripe::Checkout::Session.retrieve(@plan3.id)

    #@plan3_customer = session_plan3.customer

    @plan4 = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: @user.email,
      line_items: [{
        price_data: {
          currency: 'jpy',
          product: ENV['PRODUCT4'],
          unit_amount: 18000,
          recurring: {interval: "month"}
        },
        quantity: 1,
      }],
      mode: 'subscription',
      success_url: success_url(@user.id),
      cancel_url: cancel_url,
    )

    @plan5 = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: @user.email,
      line_items: [{
        price_data: {
          currency: 'jpy',
          product: ENV['PRODUCT5'],
          unit_amount: 25000,
          recurring: {interval: "month"}
        },
        quantity: 1,
      }],
      mode: 'subscription',
      success_url: success_url(@user.id),
      cancel_url: cancel_url,
    )

    @plan6 = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: @user.email,
      line_items: [{
        price_data: {
          currency: 'jpy',
          product: ENV['PRODUCT6'],
          unit_amount: 50000,
          recurring: {interval: "month"}
        },
        quantity: 1,
      }],
      mode: 'subscription',
      success_url: success_url(@user.id),
      cancel_url: cancel_url,
    )

    @plan7 = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: @user.email,
      line_items: [{
        price_data: {
          currency: 'jpy',
          product: ENV['PRODUCT7'],
          unit_amount: 100000,
          recurring: {interval: "month"}
        },
        quantity: 1,
      }],
      mode: 'subscription',
      success_url: success_url(@user.id),
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

  def customer_portal
    
    #checkout_session_id = @plan3.id
    checkout_sessionId = params[:sessionId]
    checkout_session = Stripe::Checkout::Session.retrieve(checkout_sessionId)
    return_url = ENV['DOMAIN']

    session = Stripe::BillingPortal::Session.create({
      customer: checkout_session['customer'],
      return_url: return_url
    })
    
    redirect_to session.url

  end

  def webhook
    payload = request.body.read
    event = nil

    begin
      event = Stripe::Event.construct_from(
        JSON.parse(payload, symbolize_names: true)
      )
    rescue JSON::ParserError => e
      # Invalid payload
      status 400
      return
    end

    # Handle the event
    case event.type
    when 'payment_intent.succeeded'
      payment_intent = event.data.object # contains a Stripe::PaymentIntent
      # Then define and call a method to handle the successful payment intent.
      # handle_payment_intent_succeeded(payment_intent)
    when 'payment_method.attached'
      payment_method = event.data.object # contains a Stripe::PaymentMethod
      # Then define and call a method to handle the successful attachment of a PaymentMethod.
      # handle_payment_method_attached(payment_method)
    # ... handle other event types
    when 'checkout.session.completed'
      checkout_session = event.data.ojbect
    else
      puts "Unhandled event type: #{event.type}"
    end

    status 200
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
