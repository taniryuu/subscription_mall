# frozen_string_literal: true

class Owners::OmniauthCallbacksController < Devise::OmniauthCallbacksController
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

  def facebook_owner
    callback_from :facebook_owner
  end

  def twitter_owner
    callback_from :twitter_owner
  end

  def line_owner; basic_action end

  private

  def basic_action # line ログイン用メソッドです
    @omniauth = request.env['omniauth.auth']
    if @omniauth.present?
      @profile = Owner.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
      if @profile
        @profile.set_values(@omniauth)
        sign_in(:owner, @profile)
      else
        @profile = Owner.new(provider: @omniauth['provider'], uid: @omniauth['uid'])
        email = @omniauth['info']['email'] ? @omniauth['info']['email'] : "#{@omniauth['uid']}-#{@omniauth['provider']}@example.com"
        @profile = current_owner || Owner.create!(provider: @omniauth['provider'], uid: @omniauth['uid'], email: email, name: @omniauth['info']['name'], password: Devise.friendly_token[0, 20])
        @profile.set_values(@omniauth)
        sign_in(:owner, @profile)
        # redirect_to edit_owner_path(@profile.user.id) and return
      end
    end
    flash[:notice] = "ログインしました"
    redirect_to owner_path(@profile)
  end


  def fake_email(uid,provider) # line ログイン用メソッドです
     return "#{auth.uid}-#{auth.provider}@example.com"
  end

  def callback_from(provider) # facebook, twitter ログイン用メソッドです
    provider = provider.to_s

    @owner = Owner.find_for_oauth(request.env['omniauth.auth'])

    if @owner.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @owner, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth'].except("extra")
      redirect_to new_owner_registration_url
    end
  end
end
