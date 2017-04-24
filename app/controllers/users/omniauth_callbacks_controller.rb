class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  %w(facebook).each do |provider|
    define_method provider do
      @user = User.from_omniauth request.env["omniauth.auth"]
      if @user.persisted?
        flash[:notice] = t "devise.omniauth_callbacks.success",
          kind: "Facebook"
        sign_in_and_redirect @user, event: :authentication
      else
        session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
        redirect_to new_user_registration_url
      end
    end
  end
end
