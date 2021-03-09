class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  #本番環境ででErrorが発生したらrescue500,rescue404で処理を行う
  # rescue_from StandardError, with: :rescue500
  # rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    added_attrs = [ :email, :name, :password, :password_confirmation, :kana, :address, :phone_number, :line_id, :payee, :score ] # deviseで登録するために追加している
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

  def after_sign_in_path_for(resource) #deviseでログイン後のリダイレクト先を指定
    case resource
    when Admin
      if current_admin.present?
        account_admin_url
      else
        flash[:danger] = "ログインしてください"
        root_url
      end
    when User
      if current_user.present?
        user_account_user_url(resource)
      else
        flash[:danger] = "ログインしてください"
        root_url
      end
    when Owner
      if current_owner.present?
        owner_account_owner_url(resource)
      else
        flash[:danger] = "ログインしてください"
        root_url
      end
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  # current_userのサブスクプラン支払い詳細
  def payment_check
    if current_user.present?
      @pay = current_user.customer_id
    end
    if @pay.present?
      # 現在の支払い情報
      @payment = Stripe::Checkout::Session.retrieve(@pay)
      # サブスクプラン更新用
      @sub = Stripe::Subscription.retrieve(@payment.subscription)
    end
  end

  # ユーザー削除時orプラン解除時
  # ログイン中のユーザーが何かしらのプランに加入していた場合支払いを停止する
  def payment_planning_delete
    @ticket = Ticket.find_by(params[:current_user])
    @ticket.destroy if @ticket.present?
    current_user.update(issue_ticket_day: nil)
    if current_user.customer_id.present?
      @payment = Stripe::Checkout::Session.retrieve(current_user.customer_id)
      Stripe::Subscription.delete(@payment.subscription)
      current_user.update!(customer_id: "", user_price: "")
    end
  end

  # 未認証ならトップページにリダイレクトされる。
  def sms_auth_false?
    unless current_user.sms_auth?
      redirect_to sms_auth_users_url
    end
  end

    # 現在ログインしているユーザーを許可します。
  def login_current_user
    @user = User.find(params[:id]) if @user.blank?
    unless current_user?(@user)
      flash[:danger] = "ログインしている利用者様のみ確認可能なページです。"
      redirect_to root_url, notice: 'ログインしている利用者様のみ確認可能なページです。'
    end
  end

  # 現在ログインしている管理者を許可します。
  def login_current_admin
    unless current_admin.present? or current_owner.present?
      flash[:danger] = "管理者のみ確認可能なページです。"
      redirect_to root_url, notice: '管理者のみ確認可能なページです。'
    end
  end

  def only_current_admin
    unless current_admin.present?
      flash[:danger] = "管理者のみ確認可能なページです。"
      redirect_to root_url, notice: '管理者のみ確認可能なページです。'
    end
  end

  # 現在ログインしている経営者を許可します。
  def login_current_owner
    @owner = Owner.find(params[:id]) if @owner.blank?
    unless current_owner?(@owner)
      flash[:danger] = "ログインしている経営者様のみ確認可能なページです。"
      redirect_to root_url, notice: 'ログインしている経営者様のみ確認可能なページです。'
    end
  end

  # 現在ログインしている利用者または現在ログインしている管理者を許可します
  def authenticate_user_or_admin!
    if admin_signed_in?
      authenticate_admin!
    elsif user_signed_in?
      authenticate_user!
    else
      redirect_to root_url, notice: 'ログインしている利用者様のみ確認可能なページです。'
    end
  end

  # 現在ログインしている経営者または現在ログインしている管理者を許可します
  def authenticate_owner_or_admin!
    if admin_signed_in?
      authenticate_admin!
    elsif owner_signed_in?
      authenticate_owner!
    else
      redirect_to root_url, notice: 'ログインしている経営者様のみ確認可能なページです。'
    end
  end

    private

    def rescue400(e)
      render "errors/not_found", notice: '表示できないページです。サイトに戻り巡グルメをお楽しみください。', status: 404
    end

    #引数eを指定。errorオブジェクトが入る
    def rescue500(e)
      render "errors/server_error", notice: '表示できないページです。サイトに戻り巡グルメをお楽しみください。', status: 500
    end


end
