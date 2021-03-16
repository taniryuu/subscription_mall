# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :create, only: [:complete]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  # before_action :set_user, only: [:new, :create, :show]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    @user= User.new(sign_up_params)
    render :new and return if params[:back]
  end

  def confirm
    @user = User.new(sign_up_params)
    if @user.valid?
      render :confirm
    else
     render :new
    end
  end

  # 新規追加
  def complete
    if User.find_by(email: params[:user][:email]).blank?
      @user.save
      flash[:success] = "登録に成功しました"
      sign_in @user
      UserMailer.with(user: @user).welcome_email.deliver_now
      UserMailer.with(user: @user).notice_user_joining_email.deliver_now
    else
      flash[:worning] = "メールアドレスが既に登録されています"
      redirect_to new_user_session_url
    end
  end

  # アカウント登録後
  def after_sign_up_path_for(resource)
    users_sign_up_complete_path(resource)
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  def destroy
    UserMailer.cancel_email(@user).deliver
    resource.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed
    yield resource if block_given?
    redirect_to root_url(resource_name)
  end
  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :kana, :email, :phone_number, :password, :password_confirmation)
    end

    def sign_up_params
      params.require(:user).permit(:name, :email, :phone_number, :password, :password_confirmation)
    end
end
