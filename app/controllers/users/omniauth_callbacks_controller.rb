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
  def line
    basic_action
  end

  private

  def basic_action
    @omniauth = request.env['omniauth.auth']
    if @omniauth.present?
      @profile = User.find_or_initialize_by(provider: @omniauth['provider'], uid: @omniauth['uid'])
      if @profile.email.blank?
        email = @omniauth['info']['email'] ? @omniauth['info']['email'] : fake_email(@omniauth["uid"], @omniauth["provider"])
        @profile = current_user || User.create!(provider: @omniauth['provider'], uid: @omniauth['uid'], email: email, name: @omniauth['info']['name'], password: Devise.friendly_token[0, 20], confirmed_at: Time.current)
      end
      @profile.set_values(@omniauth)
      sign_in(:user, @profile)

      flash[:notice] = 'ログインしました'
      redirect_to root_path

    else
      flash[:alert] = '認証に失敗しました'
      redirect_to user_session_path
    end
  end

  def fake_email(uid, provider)
    "#{uid}-#{provider}@example.com"
  end
end
