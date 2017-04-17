class Users::RegistrationsController < Devise::RegistrationsController
  def create
    @user_sign_up = User.new user_params
    if @user_sign_up.save
      sign_in @user_sign_up
      flash[:success] = "Login success"
      redirect_to root_path
    else
      render 'devise/sessions/new'
    end
  end

  private
  def user_params
    params.require(:user).permit :email, :password, :password_confirmation
  end
end
