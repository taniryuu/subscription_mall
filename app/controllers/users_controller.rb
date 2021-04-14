class UsersController < ApplicationController
  before_action :set_user, only: [:create, :show, :edit, :update, :destroy, :user_edit, :user_edit_update]
  before_action :set_owner, only: %i(user_subscription_email user_private_store_email)
  before_action :set_subscription, only: %i(user_subscription_email user_subscription_confirm user_subscription_thanks)
  before_action :set_private_store, only: %i(user_private_store_email user_private_store_confirm user_private_store_thanks)
  before_action :payment_planning_delete, only: :destroy
  before_action :login_current_admin, only: %i(index)
  before_action :login_current_user, only: %i(user_account edit)
  before_action :login_current_owner, only: %i()

  def index
    @users = User.with_deleted.where(deleted_at: nil).paginate(page: params[:page], per_page: 20)
    @search = params[:search]
  end

  def deleted_users
    @users = User.with_deleted.where.not(deleted_at: nil)
  end

  def update_deleted_users
    @user.with_deleted.find(params[:id]).restore
    redirect_to users_url
  end

  def user_subscription_email#利用者から経営者へメール
  end

  def user_subscription_confirm#利用者から経営者へメール確認画面
    @subscription.update(params[:subscription].permit(:subject, :message))
  end

  def user_subscription_thanks#利用者から経営者へメールありがとう画面
    @subscription.update(params[:subscription].permit(:subject, :message))
    UserMailer.with(subscription: @subscription, user: current_user).user_subscription_email.deliver_now
  end

  def user_private_store_email

  end

  def user_private_store_confirm
    @private_store.update(params[:private_store].permit(:subject, :message))
  end

  def user_private_store_thanks
    @private_store.update(params[:private_store].permit(:subject, :message))
    UserMailer.with(private_store: @private_store, user: current_user).user_private_store_email.deliver_now
  end

  def show
    @ticket = Ticket.find_by(user_id: @user.id)
  end

  def user_account
    @user = User.find(params[:id])
  end

  def edit
  end

  def new
  end

  def thanks
    @user = User.find(params[:id])
  end

  def update
    if current_user.update_attributes(user_params)
      current_user.update(sms_auth: false) if current_user.saved_change_to_phone_number?
      flash[:success] = "#{current_user.name}様の情報を更新しました。"
      sign_in(current_user, bypass: true)
      redirect_to user_account_user_url(current_user), notice: "更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(@user)
    yield @user if block_given?
    flash[:danger] = "#{@user.name}様のデータを削除しました"
    redirect_to users_url, notice: "削除しました。"
  end

  def ticket
    #@owner = Owner.find(params[:id])
    @subscription = Subscription.find(params[:id])
    @owner = Owner.find(@subscription.owner_id)
  end

  # ユーザーの名前をあいまい検索機能
  def search
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
    else
      @users = User.none
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def set_owner
      @owner = Owner.find(params[:id])
    end

    def set_private_store
      @private_store = PrivateStore.find(params[:id])
    end

    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :kana, :email, :phone_number, :address)
    end


      # ログイン状態を返します。
    def limitation_login_user
      if @current_user.present?
        flash[:notice] = "すでにログイン状態です。"
        redirect_to root_url
      end
    end
end
