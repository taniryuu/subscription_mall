class OwnersController < ApplicationController
  before_action :set_owner, only: [:to_user_email, :new, :create, :show, :edit, :update, :destroy]

  def index
    @owners = Owner.all
  end

  def deleted_owners#論理削除した経営者
    @owners = Owner.with_deleted.where.not(deleted_at: nil)
  end

  def update_deleted_owners#論理削除用のアクション
    @owner = Owner.with_deleted.find(params[:id]).restore
    redirect_to owners_url
  end

  def user_email#経営者から利用者へメール作成
    @user = User.find(params[:id])
  end

  def to_user_email#経営者から利用者へメール送信アクション
    user = User.find(params[:id])
    owner = Owner.find(params[:id])
    User.new(user_params)

    OwnerMailer.owner_email(owner, user).deliver
    redirect_to users_url
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
    @subscription = Subscription.find_by(params[:id])
    @subscriptions = Subscription.where.not(name: nil).size
  end

  def edit
  end

  def update
    if @owner.update(owner_params)
      flash[:success] = "#{@owner.name}様の情報を更新しました。"
      redirect_to owners_url
    else
      render :edit
    end
  end

  def destroy
    @owner.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(@owner)
    yield @owner if block_given?
    flash[:danger] = "#{@owner.name}様のデータを削除しました"
    redirect_to owners_url
  end

  private

    def set_owner
      @owner = Owner.find(params[:id])
    end

    def owner_params
      params.require(:owner).permit(:name, :kana, :email, :phone_number, :password, :password_confirmation)
    end

    def user_params
      params.require(:user).params(:name, :email, :subject, :message)
    end

    def email_params
      params.require(:user).permit(owner: [:name, :email])
    end
end
