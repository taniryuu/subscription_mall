class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
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
end
