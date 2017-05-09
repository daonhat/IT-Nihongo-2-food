class LikesController < ApplicationController

  def create
    @food = Food.find_by id: params[:food_id]
    Like.create user: current_user, food: @food
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  def destroy
    like = Like.find_by id: params[:id]
    @food = Food.find_by id: like.food_id
    like.destroy
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end
end
