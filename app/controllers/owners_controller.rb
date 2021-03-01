class OwnersController < ApplicationController
  before_action :set_owner, only: [:to_user_email, :new, :create, :show, :edit, :update, :destroy, :owner_edit, :owner_edit_update]
  before_action :set_subscription, only: [:owner_account]

  def index
    @owners = Owner.paginate(page: params[:page], per_page: 20)
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
    if @subscriptions_count == 0
      # @subscription_count = Subscription.find(params[:id]) 変更前
      @subscriptions_count = Subscription.find_by(owner_id: params[:id]) # 変更後
    else
      # @shop = Shop.find(params[:shop_id])
      @subscriptions_count = Subscription.where.not(name: nil).size
    end
    @subscriptions = @owner.subscriptions.where(owner_id: @owner.id)  
  end

  def owner_account
    @owner = Owner.find(params[:id])
    # @subscription = Subscription.find_by(params[:id])
    @subscriptions = Subscription.where.not(name: nil).size
  end

  def edit
  end

  def update
    if current_owner.update!(owner_params)
      sign_in(current_owner, bypass: true)
      flash[:success] = "#{current_owner.name}様の情報を更新しました。"
      redirect_to owner_account_owner_url(current_owner.id)
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

  # オーナーの名前をあいまい検索機能
  def search
    if params[:name].present?
      @owners = Owner.where('name LIKE ?', "%#{params[:name]}%")
    else
      @owners = Owner.none
    end
  end

  private

    def set_owner
      @owner = Owner.find(params[:id])
    end
    def set_subscription
      @subscription = Subscription.find_by(params[:id])
    end

    def owner_params
      params.require(:owner).permit(:name, :kana, :email, :phone_number, :address, :password, :password_confirmation)
    end

    def user_params
      params.require(:user).params(:name, :email, :subject, :message)
    end

    def email_params
      params.require(:user).permit(owner: [:name, :email])
    end
end
