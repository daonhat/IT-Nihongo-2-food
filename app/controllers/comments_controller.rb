class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
   @comment = current_user.comments.build comment_params
   @food = Food.find @comment.food_id
   if @comment.save
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
   else
     flash.now[:danger] = "error"
     redirect_to :back
   end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @comment.update_attributes comment_params
      @food = Food.find @comment.food_id
      respond_to do |format|
        # format.html {redirect_to admin_categories_path}
        format.js
      end
    end
  end

  def destroy
    @comment = current_user.comments.find params[:id]
    @food = @comment.food
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @food }
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :food_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
