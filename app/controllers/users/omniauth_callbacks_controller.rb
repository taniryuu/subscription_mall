# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  # def facebook
   # callback_from :facebook
  # end

  def twitter
    callback_from :twitter
  end

  def google_oauth2
    callback_from :google
  end

  def line; basic_action end

  def instagram
    callback_from :instagram
  end

  private

  def basic_action # line ログイン用メソッドです
    @omniauth = request.env['omniauth.auth']
    if @omniauth.present?
      @profile = User.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
      if @profile
        @profile.set_values(@omniauth)
        sign_in(:user, @profile)
      else
        @profile = User.new(provider: @omniauth['provider'], uid: @omniauth['uid'])
        email = @omniauth['info']['email'] ? @omniauth['info']['email'] : "#{@omniauth['uid']}-#{@omniauth['provider']}@example.com"
        @profile = current_user || User.create!(provider: @omniauth['provider'], uid: @omniauth['uid'], email: email, name: @omniauth['info']['name'], password: Devise.friendly_token[0, 20])
        @profile.set_values(@omniauth)
        sign_in(:user, @profile)
        # redirect_to edit_user_path(@profile.user.id) and return
      end
    end
    flash[:notice] = "ログインしました"
    redirect_to user_path(@profile)
  end


  def fake_email(uid,provider) # line ログイン用メソッドです
     return "#{auth.uid}-#{auth.provider}@example.com"
  end

  # 元々omniauth_callback_controller.rbにあるメッソド def callback_from(provider) # facebook, twitter ログイン用メソッドです
end
