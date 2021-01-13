# frozen_string_literal: true

class Owners::RegistrationsController < Devise::RegistrationsController
  before_action :create, only: [:complete]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  #def new
  #  super
  # end

  # POST /resource
  def create
    @owner= Owner.new(sign_up_params)
    render :new and return if params[:back]
  end

  def confirm
    @owner = Owner.new(sign_up_params)
    if @owner.valid?
      render :confirm
    else
     render :new
    end
  end

  # 新規追加
  def complete
    @owner.save
    OwnerMailer.with(owner: @owner).welcome_email.deliver_now
  end

  # アカウント登録後
  def after_sign_up_path_for(resource)
    owners_sign_up_complete_path(resource)
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
    UserMailer.cancel_email(@owner).deliver
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

    def sign_up_params
      params.require(:owner).permit(:name, :email, :phone_number, :store_information, :payee, :password, :password_confirmation)
    end
end
