class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # %w(facebook github).each do |provider|
  #   define_method provider do
  #     @user = User.from_omniauth request.env["omniauth.auth"]
  #     if @user.persisted?
  #       flash[:notice] = t "devise.omniauth_callbacks.success",
  #         kind: provider
  #       sign_in_and_redirect @user, event: :authentication
  #     else
  #       flash[:warning] = "Please certain your email is public"
  #       session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
  #       redirect_to new_user_session_url
  #     end
  #   end
  # end
  
  def github
    handle_redirect('devise.github_uid', 'Github')
  end

  def facebook
    handle_redirect('devise.facebook_data', 'Facebook')
  end
  
  private

  def handle_redirect(_session_variable, kind)
    # here we force the locale to the session locale so it siwtches to the correct locale
    I18n.locale = session[:omniauth_login_locale] || I18n.default_locale
    sign_in_and_redirect user, event: :authentication
    set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
  end

  def user
    User.from_omniauth request.env["omniauth.auth"]
  end
  
  
end
