class UserPlansController < ApplicationController
  before_action :authenticate_user!
  
  before_action :set_subscription, only: %i(new edit update confirm update_confirm destroy)
  before_action :set_owner, only: %i(new edit)
  before_action :set_plan, only: %i(confirm update_confirm)
  before_action :set_plans, only: %i(new edit confirm update_confirm)
  before_action :payment_check, only: %i(new edit confirm update_confirm update destroy)
  before_action :payment_planning_delete, only: :destroy
  # stripe決済成功時
  def success
    current_user.update!(customer_id: current_user.session_id, session_id: "")
  end

  # stripe決済失敗時
  def cancel
    current_user.update!(session_id: "")
  end

  # サブスクプラン新規登録
  def new
  end

  # サブスク新規登録確認画面
  def confirm
    current_user.update!(session_id: @plan.id)
  end

  # サブスクプラン更新確認画面
  def update_confirm
    current_user.update!(session_id: params[:session])
  end

  def edit
  end

  def update
    @sub_now.plan = current_user.session_id
    current_user.update!(session_id: "")
    if @sub_now.save
      flash[:success] = "正常に更新されました"
      redirect_to owner_subscription_url(@subscription, owner_id: @subscription.owner_id)
    end
  end

  def destroy
    redirect_to owner_subscription_url(@subscription, owner_id: @subscription.owner_id)
  end

  private

    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def set_owner
      @owner = Owner.find(params[:owner_id])
    end

    # stripe APIからプランを取得
    def set_plan
      @confirm_plan = Stripe::Plan.retrieve(
        params[:session]
      )
      
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
    end

    # ダッシュボードで作成した
    def set_plans
      @plans = []
      Stripe::Plan.list.reverse_each do |plan|
        @plans.push(plan) if plan.object = "active"
      end
    end
end
