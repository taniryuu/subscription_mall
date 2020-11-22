class AdminsController < ApplicationController
  before_action :set_admin, only: [:new, :create, :show, :edit, :update, :destroy]
  
  def show
  end

  def admin_account
    @admin = Admin.find(params[:id])
  end

  def edit
  end

  def update
    if @admin.update_attributes(admin_params)
      flash[:success] = "#{@admin.name}様の情報を更新しました。"
      redirect_to admin_url
    else
      render :edit
    end
  end

  def destroy
    @admin.destroy
    flash[:success] = "#{@admin.name}様のデータを削除しました。"
    redirect_to admin_url
  end

  private

    def set_admin
      @admin = Admin.find(params[:id])
    end

    def admin_params
      params.require(:admin).permit(:name, :kana, :line_id, :email, :phone_number, :password, :password_confirmation)
    end
end
