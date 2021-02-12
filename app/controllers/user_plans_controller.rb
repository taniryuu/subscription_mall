class UserPlansController < ApplicationController
  before_action :set_subscription, only: %i(new edit update confirm)
  before_action :set_owner, only: %i(new select_plans new edit destroy)
  before_action :payment_check, only: %i(new edit confirm update)

  # stripe決済成功時
  def success
    UserPlan.create!(
      customer_id: current_user.session_id,
      user_id: current_user.id,
      subscription_id: current_user.subscription_id
    )
    current_user.update!(session_id: "", subscription_id: "")
  end

  # stripe決済失敗時
  def cancel
    current_user.update!(session_id: "", subscription_id: "")
  end

  # サブスク新規登録
  def new
  end

  # サブスク新規登録確認画面
  def confirm
    current_user.update!(session_id: params[:session].to_i)
    @price = current_user.session_id

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

  # サブスクプラン更新確認画面
  def update_confirm
    current_user.update!(session_id: params[:session].to_i)
    @price = current_user.session_id
    @plan = Stripe::Subscription.update()
    current_user.update!(session_id: @plan.id, subscription_id: @subscription.id)
  end

  def edit
    
  end

  def update
    
  end

  def destroy

  end

  private

    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def set_owner
      @owner = Owner.find(params[:owner_id])
    end

    def payment_check
      payment = current_user.user_plans.find_by(subscription_id: params[:id])
      if payment.present?
        @payment = Stripe::Checkout::Session.retrieve(payment.customer_id)
        @aa = Stripe::Subscription.retrieve(@payment.subscription)
      end
    end
end
