class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  %w(facebook github).each do |provider|
    define_method provider do
      @user = User.from_omniauth request.env["omniauth.auth"]
      if @user.persisted?
        flash[:notice] = t "devise.omniauth_callbacks.success",
          kind: "Github"
        sign_in_and_redirect @user, event: :authentication
      else
        flash[:warning] = "Please certain your email is public"
        session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
        redirect_to new_user_session_url
      end
    end
  end
end
