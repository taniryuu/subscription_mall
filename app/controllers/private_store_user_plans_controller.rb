class PrivateStoreUserPlansController < ApplicationController
  before_action :set_private_store, only: %i(new edit update confirm update_confirm destroy)
  before_action :set_owner, only: %i(new edit)
  before_action :payment_check, only: %i(new edit confirm update_confirm update destroy)

  # stripe決済成功時
  def success
    PrivateStoreUserPlan.create!(
      customer_id: current_user.session_id,
      user_id: current_user.id,
      private_store_id: current_user.private_store_id
    )
    current_user.update!(session_id: "", private_store_id: "")
  end

  # stripe決済失敗時
  def cancel
    current_user.update!(session_id: "", private_store_id: "")
  end

  # サブスクプラン新規登録
  def new
  end

  # サブスク新規登録確認画面
  def confirm
    current_user.update!(session_id: params[:session].to_i)
    @price = current_user.session_id

    @plan = Stripe::Checkout::Session.create(
      success_url: private_store_success_url,
      cancel_url: private_store_cancel_url,
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
        price: params[:session],
        quantity: 1},
      ],
      mode: 'subscription',
    )

    current_user.update!(session_id: @plan.id, private_store_id: @private_store.id)
  end

  # サブスクプラン更新確認画面
  def update_confirm
    current_user.update!(session_id: params[:session])
    @price = current_user.session_id
  end

  def edit
  end

  def update
    @pri.plan = params[:value]
    if @pri.save
      redirect_to owner_private_store_url(@private_store, owner_id: @private_store.owner_id)
    else
      redirect_to root_url
    end
  end

  def destroy
    Stripe::Subscription.delete(@private_store_payment.private_store)
    PrivateStoreUserPlan.delete(@private_store_pay)
    redirect_to owner_private_store_url(@private_store, owner_id: @private_store.owner_id)
  end

  private

    def set_private_store
      @private_store = PrivateStore.find(params[:id])
    end

    def set_owner
      @owner = Owner.find(params[:owner_id])
    end

    def payment_check
      @private_store_pay = current_user.private_store_user_plans.find_by(private_store_id: params[:id])
      if @private_store_pay.present?
	@private_store_payment = Stripe::Checkout::Session.retrieve(@private_store_pay.customer_id)
	@pri = Stripe::Subscription.retrieve(@private_store_payment.private_store)
      end
    end
end
