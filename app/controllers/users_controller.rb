class UsersController < ApplicationController
  before_action :set_user, only: [:new, :create, :show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def user_account
    @user = User.find(params[:id])
  end

  def edit
  end

  def new
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.name}様の情報を更新しました。"
      redirect_to users_url
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}様のデータを削除しました。"
    redirect_to users_url
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :kana, :email, :phone_number, :password, :password_confirmation)
    end
end
