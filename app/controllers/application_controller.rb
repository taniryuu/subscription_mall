class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
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
        admin_account_admin_path(resource)
      else
        flash[:danger] = "ログインしてください"
        root_path(resource)
      end
    when User
      if current_user.present?
        user_account_user_path(resource)
      else
        flash[:danger] = "ログインしてください"
        root_path(resource)
      end
    when Owner
      if current_owner.present?
        owner_account_owner_path(resource)
      else
        flash[:danger] = "ログインしてください"
        root_path(resource)
      end
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
