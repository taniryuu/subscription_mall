class AdminsController < ApplicationController
  before_action :set_user, only: %i(user_edit user_update)
  before_action :set_owner, only: %i(owner_edit owner_update)
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

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_owner
      @owner = Owner.find(params[:owner_id])
    end

    def admin_params
      params.require(:admin).permit(:name, :kana, :line_id, :email, :phone_number, :password, :password_confirmation)
    end

    def owner_params
      params.require(:owner).permit(:name, :kana, :email, :phone_number, :address, :password, :password_confirmation)
    end

    def user_params
      params.require(:user).permit(:name, :kana, :email, :phone_number, :address, :password, :password_confirmation)
    end

    def admin_lock
      unless current_admin.present?
        redirect_to root_url, notice: '権限がありません'
      end
    end
end
