class PrivateStoreUserPlansController < ApplicationController
  #before_action :set_plan, only: %i(confirm update_confirm)
  before_action :set_plans, only: %i(new edit)
  before_action :set_plan_by_price, only: :private_store_plan

  before_action :authenticate_user!
  before_action :payment_check, only: %i(new edit confirm update_confirm update destroy)
  before_action :payment_planning_delete, only: :destroy
  # before_action :sms_auth_false?, only: %i(new confirm destroy)

  # stripe決済成功時
  def success
    current_user.update!(customer_id: current_user.session_id, session_id: "", price: current_user.session_price, session_price: "")
    if current_user.select_trial && current_user.price == 1000
      current_user.update!(trial_stripe_success: true)
    else
      current_user.update!(trial_stripe_success: false)
    end
  end

  # stripe決済失敗時
  def cancel
    current_user.update!(session_id: "")
  end

  # サブスクプラン新規登録
  def new
    @private_store = PrivateStore.find(params[:id])

    if @private_store.trial == true && current_user.select_trial
      if Rails.env.development? || Rails.env.test?
        @trial_plan = Stripe::Checkout::Session.create(
          payment_method_types: ['card'],
          customer_email: current_user.email,
          line_items: [{
            price_data: {
              currency: 'jpy',
              product: 'prod_J3NbUHqtOpmfgT',
              unit_amount: 1000,
              recurring: {interval: "month"}
            },
            quantity: 1,
          }],
          mode: 'subscription',
          success_url: success_url,
          cancel_url: cancel_url,
        )
        current_user.update!(session_id: @trial_plan.id, session_price: @trial_plan.amount_subtotal, used_trial: true)
      end
      if Rails.env.production?
        @trial_plan = Stripe::Checkout::Session.create(
          payment_method_types: ['card'],
          customer_email: current_user.email,
          line_items: [{
            price_data: {
              currency: 'jpy',
              product: 'prod_J3NbUHqtOpmfgT',
              unit_amount: 1000,
              recurring: {interval: "month"}
            },
            quantity: 1,
          }],
          mode: 'subscription',
          success_url: success_url,
          cancel_url: cancel_url,
        )
        current_user.update!(session_id: @trial_plan.id, session_price: @trial_plan.amount_subtotal, used_trial: true)
      end

    else
      
      if Rails.env.development? || Rails.env.test?
        PrivateStore.count.times do |i|
          if @private_store.ordinal == i + 1
            @private_store_plan = Stripe::Checkout::Session.create(
              payment_method_types: ['card'],
              customer_email: current_user.email,
              line_items: [{
              price_data: {
              currency: 'jpy',
              product: 'prod_Itdb3ZOVEaX3iU',
              unit_amount: @private_store.price,
              recurring: {interval: "month"}
                },
                quantity: 1,
              }],
              mode: 'subscription',
              success_url: success_url,
              cancel_url: cancel_url,
            )
            current_user.update!(session_id: @private_store_plan.id, session_price: @private_store_plan.amount_subtotal)
          end
        end
      end
      if Rails.env.production?
        PrivateStore.count.times do |i|
          if @private_store.ordinal == i + 1
            @private_store_plan = Stripe::Checkout::Session.create(
              payment_method_types: ['card'],
              customer_email: current_user.email,
              line_items: [{
              price_data: {
              currency: 'jpy',
              product: 'prod_Itdb3ZOVEaX3iU',
              unit_amount: @private_store.price,
              recurring: {interval: "month"}
                },
              quantity: 1,
              }],
              mode: 'subscription',
              success_url: success_url,
              cancel_url: cancel_url,
            )
            current_user.update!(session_id: @private_store_plan.id, session_price: @private_store_plan.amount_subtotal)
          end
        end
      end
    end
  end
	  
  # サブスク新規登録確認画面
  def confirm
    current_user.update!(session_id: @private_store_plan.id, session_price: @private_store_plan.amount_subtotal)
  end

  # サブスクプラン更新確認画面
  def update_confirm
    current_user.update!(session_id: params[:session], session_price: @private_store_plan.amount_subtotal)
  end

  def edit
    #@trial_plan = Stripe::Checkout::Session.create(
    #  payment_method_types: ['card'],
    #  customer_email: current_user.email,
    #  line_items: [{
    #    price_data: {
    #      currency: 'jpy',
    #      product: 'prod_J3NbUHqtOpmfgT',
    #      unit_amount: 1000,
    #      recurring: {interval: "month"}
    #    },
    #    quantity: 1,
    #  }],
    #  mode: 'private_store',
    #  success_url: success_url,
    #  cancel_url: cancel_url,
    #)
    #current_user.update!(session_id: @trial_plan.id, session_price: @trial_plan.amount_subtotal)

  end

  def update
    @sub.plan = current_user.session_id
    current_user.update!(session_id: "", price: current_user.session_price, session_price: "", issue_ticket_day: nil)
    if @sub.save
      flash[:success] = "正常に更新されました"
      redirect_to current_user
    end
    @ticket = Ticket.find_by(params[:current_user])
    @ticket.destroy if @ticket.present?
  end

  def destroy
    flash[:danger] = "正常に解除されました"
    redirect_to root_url
  end

  private

    # stripe APIからプランを取得
    def set_plan
      # 変更予定のサブスクプラン
      @confirm_plan = Stripe::Plan.retrieve(
        params[:session]
      )

      # サブスク登録
      @private_store_plan = Stripe::Checkout::Session.create(
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
    end

    # ダッシュボードで作成した
    def set_plans
      @plans = []
      Stripe::Plan.list.reverse_each do |plan|
	p "planは#{plan}"
        p "plan.idは#{plan.id}"
        p "plan.metadtaは#{plan.metadata}"
        if Rails.env.development? || Rails.env.test?
          @plans.push(plan) if plan.product == "prod_JBsFLfsceVMW36"
        elsif Rails.env.production?
          @plans.push(plan) if plan.product == "prod_JBsFLfsceVMW36"
        end
      end
    end
    
    def set_plan_by_price
      if params[:private_store].to_i == -1
        @private_store = nil
      else
        @private_store = Subscription.find(params[:private_store])
      end
      if Rails.env.development? || Rails.env.test?
        if @private_store.present? && @private_store.trial == true && current_user.select_trial
          @plan_by_price = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            customer_email: current_user.email,
            line_items: [{
              price_data: {
                currency: 'jpy',
                product: 'prod_J3NbUHqtOpmfgT',
                unit_amount: 1000,
                recurring: {interval: "month"}
              },
              quantity: 1,
            }],
            mode: 'subscription',
            success_url: success_url,
            cancel_url: cancel_url,
          )
          current_user.update!(session_id: @plan_by_price.id, session_price: @plan_by_price.amount_subtotal, used_trial: true)
        else
          @plan_by_price = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            customer_email: current_user.email,
            line_items: [{
              price_data: {
                currency: 'jpy',
                product: 'prod_JBsFLfsceVMW36',
                unit_amount: params[:price].to_i,
                recurring: {interval: "month"}
              },
              quantity: 1,
            }],
            mode: 'subscription',
            success_url: success_url,
            cancel_url: cancel_url,
          )
          current_user.update!(session_id: @plan_by_price.id, session_price: @plan_by_price.amount_subtotal, used_trial: true)
        end
      elsif Rails.env.production?
        if @private_store.present? && @private_store.trial == true && current_user.select_trial
          @plan_by_price = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            customer_email: current_user.email,
            line_items: [{
              price_data: {
                currency: 'jpy',
                product: 'prod_J3NbUHqtOpmfgT',
                unit_amount: 1000,
                recurring: {interval: "month"}
              },
              quantity: 1,
            }],
            mode: 'subscription',
            success_url: success_url,
            cancel_url: cancel_url,
          )
          current_user.update!(session_id: @plan_by_price.id, session_price: @plan_by_price.amount_subtotal, used_trial: true)
        else
          @plan_by_price = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            customer_email: current_user.email,
            line_items: [{
              price_data: {
                currency: 'jpy',
                product: 'prod_JBsFLfsceVMW36',
                unit_amount: params[:price].to_i,
                recurring: {interval: "month"}
              },
              quantity: 1,
            }],
            mode: 'subscription',
            success_url: success_url,
            cancel_url: cancel_url,
          )
          current_user.update!(session_id: @plan_by_price.id, session_price: @plan_by_price.amount_subtotal, used_trial: true)
        end
      end
    end
end

