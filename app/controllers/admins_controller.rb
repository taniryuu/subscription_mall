class AdminsController < ApplicationController
  before_action :set_user, only: %i(user_edit user_update)
  before_action :set_owner, only: %i(owner_edit owner_update  subscription_owner_edit subscription_owner_update private_owner_edit private_owner_update)
  before_action :set_subscription, only: %i(subscription_owner_edit subscription_owner_update)
  before_action :set_private_store, only: %i(private_owner_edit private_owner_update)
  before_action :login_current_admin, only: %i(user_edit owner_edit)

  require 'rqrcode'

  def show
  end

  def account
  end

  def edit
  end

  def update
    if current_admin.update_attributes(admin_params)
      flash[:success] = "#{current_admin.name}様の情報を更新しました。"
      redirect_to account_admin_url
    else
      render :edit
    end
  end

  # User編集アクション
  def user_edit
  end

  def user_update
    if @user.update_attributes(user_params)
      @user.update!(sms_auth: false) if @user.phone_number_changed?
      flash[:success] = "#{@user.name}様の情報を更新しました"
      redirect_to users_url
    else
      render :user_edit
    end
  end

  # Owner編集アクション
  def owner_edit
  end

  def owner_update
    if @owner.update(owner_params)
      flash[:success] = "#{@owner.name}様の情報を更新しました。"
      redirect_to owners_url
    else
      render :owner_edit
    end
  end

  def subscriptions_index
    @subscriptions = Subscription.includes(:owner).paginate(page: params[:page], per_page: 20)
  end

  def private_stores_index
    @private_stores = PrivateStore.all.paginate(page: params[:page], per_page: 20)
  end

  # Owner加盟店審査アクション
  def subscription_owner_edit
  end

  def subscription_owner_update
    if params[:subscription][:admin_subscription_check] == "承認" || params[:subscription][:admin_subscription_check] == "否認" || params[:subscription][:admin_subscription_check] == ""
      if params[:subscription][:admin_subscription_check] == "承認"
        params[:subscription][:admin_last_check] = "加盟承認審査済み"
        params[:subscription][:situation] = "加盟店承認済み"
      elsif params[:subscription][:admin_subscription_check] == "否認"
        params[:subscription][:admin_last_check] = "否認審査済み"
        params[:subscription][:situation] = "加盟店否認済み"
      elsif params[:subscription][:admin_subscription_check] == ""
        flash[:notice] = "審査状況の選択してください"
        render :subscription_owner_edit and return
      end
    end
    @subscription.update(subscription_owner_params)
    SubscriptionMailer.with(subscription: @subscription, new: "承認").judging_email.deliver_now
    flash[:notice] = "#{@owner.name}様の加盟店申し込みを#{@subscription.admin_subscription_check}しました"
    redirect_to admins_subscriptions_index_url and return
  end

  # Owner個人店審査アクション
  def private_owner_edit
  end

  def private_owner_update
    if params[:private_store][:admin_private_check] == "承認" || params[:private_store][:admin_private_check] == "否認" || params[:private_store][:admin_private_check] == ""
      if params[:private_store][:admin_private_check] == "承認"
        params[:private_store][:admin_last_check] = "個人承認審査済み"
        params[:private_store][:situation] = "個人店承認済み"
      elsif params[:private_store][:admin_private_check] == "否認"
        params[:private_store][:admin_last_check] = "否認審査済み"
        params[:private_store][:situation] = "個人店否認済み"
      elsif params[:private_store][:admin_private_check] == "" 
        flash[:notice] = "審査状況の選択してください"
        render :private_owner_edit and return
      end
    end
    @private_store.update(private_owner_params)
    PrivateStoreMailer.with(private_store: @private_store, new: "承認").judging_email.deliver_now
    flash[:notice] = "#{@owner.name}様の加盟店申し込みを#{@private_store.admin_private_check}しました"
    redirect_to admins_private_stores_index_url and return
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_owner
      @owner = Owner.find(params[:owner_id])
    end

    def set_private_store
      @private_store = PrivateStore.find(params[:id])
    end

    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def admin_params
      params.require(:admin).permit(:name, :kana, :line_id, :email, :phone_number, :password, :password_confirmation)
    end

    def owner_params
      params.require(:owner).permit(:name, :kana, :email, :phone_number, :address)
    end

    def user_params
      params.require(:user).permit(:name, :kana, :email, :phone_number, :address)
    end

    def subscription_owner_params
      params.require(:subscription).permit(:id, :admin_subscription_check, :admin_last_check, :situation, :name, :site)
    end

    def private_owner_params
      params.require(:private_store).permit(:id, :product_id, :admin_private_check, :admin_last_check, :situation, :name, :site)
    end

    def admin_lock
      unless current_admin.present?
        redirect_to root_url, notice: '権限がありません'
      end
    end
end
