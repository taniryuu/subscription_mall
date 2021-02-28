class UsersController < ApplicationController
  before_action :set_user, only: [:create, :show, :edit, :update, :destroy, :user_edit, :user_edit_update]
  before_action :payment_planning_delete, only: :destroy
  before_action :login_current_admin, only: %i(index)
  before_action :login_current_user, only: %i(user_account)
  before_action :login_current_owner, only: %i()

  def index
    @users = User.paginate(page: params[:page], per_page: 20)
    @search = params[:search]
  end

  def user_edit
  end

  def user_edit_update
    if @user.update_attributes(user_params)
      @user.update!(sms_auth: false) if @user.phone_number_changed?
      flash[:success] = "#{@user.name}様の情報を更新しました。"
      redirect_to users_url(@user)
    else
      render :user_edit
    end
  end

  def deleted_users
    @users = User.with_deleted.where.not(deleted_at: nil)
  end

  def update_deleted_users
    @user = User.with_deleted.find(params[:id]).restore
    redirect_to users_url
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
      flash[:success] = "#{current_user.name}様の情報を更新しました。"
      redirect_to user_account_user_url(current_user)
    else
      render :edit
    end
  end

  def destroy
    @user.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(@user)
    yield @user if block_given?
    flash[:danger] = "#{@user.name}様のデータを削除しました"
    redirect_to users_url
  end

  def ticket

    @owner = Owner.find(params[:id])
    @subscription = Subscription.find_by(params[:owner_id])

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

    def user_params
      params.require(:user).permit(:name, :kana, :email, :phone_number, :address, :password, :password_confirmation)
    end


      # ログイン状態を返します。
    def limitation_login_user
      if @current_user.present?
        flash[:notice] = "すでにログイン状態です。"
        redirect_to root_url
      end
    end
end
