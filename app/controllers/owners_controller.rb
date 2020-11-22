class OwnersController < ApplicationController
  before_action :set_owner, only: [:new, :create, :show, :edit, :update, :destroy]
  
  def index
    @owners = Owner.all
  end

  def interviews_index
    # owner = Owner.find(params[:id])
    # @interviews = owner.interviews
  end

  def show
    if @subscriptions == 0 
      @subscription = Subscription.find(params[:id])
    else
      # @shop = Shop.find(params[:shop_id])
      @subscriptions = Subscription.where.not(name: nil).size
    end
  end

  def owner_account
    @owner = Owner.find(params[:id])
  end

  def edit
  end

  def update
    if @owner.update_attributes(owner_params)
      flash[:success] = "#{@owner.name}様の情報を更新しました。"
      redirect_to owners_url
    else
      render :edit
    end
  end

  def destroy
    @owner.destroy
    flash[:success] = "#{@owner.name}様ののデータを削除しました。"
    redirect_to owners_url
  end

  private

    def set_owner
      @owner = Owner.find(params[:id])
    end

    def owner_params
      params.require(:owner).permit(:name, :kana, :email, :phone_number, :password, :password_confirmation)
    end
end
