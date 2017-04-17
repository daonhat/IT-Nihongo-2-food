class RelationshipsController < ApplicationController

  def index
    # @user  = User.find_by_id params[:user_id]
    # if @user.nil?
    #   redirect_to root_path
    #   flash[:danger] = t :user_fails
    # else
    #   relationship = params[:relationship]
    #   @title = t "follow_user.#{relationship}"
    #   @users = @user.send(relationship).paginate page: params[:page]
    # end
  end

  def create
    @user = User.find_by_id params[:followed_id]
    unless @result = current_user.following?(@user)
      current_user.follow @user
    end
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @relationship = Relationship.find_by_id params[:id]
    if @relationship
      @user = @relationship.followed
      current_user.unfollow @user
    end
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
