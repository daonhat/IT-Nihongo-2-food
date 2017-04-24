class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :owned_profile, only: [:edit, :update]

  def show
    @foods = @user.foods
  end

  def edit

  end

  def update
    if @user.update(user_params)
      if params[:user][:status_img] == '1' && params[:user][:avatar].nil?
        @user.update_attributes avatar: nil
      end
      flash[:success] = 'Your profile has been updated.'
      redirect_to @user
    else
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by id: params[:id]
    end

    def owned_profile
      unless current_user == @user
        flash[:alert] = "That profile doesn't belong to you!"
        redirect_to root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :dob, :gender, :avatar, :phonenumber)
    end
end
