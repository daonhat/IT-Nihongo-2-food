class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :edit, :update, :destroy]

  # GET /foods
  # GET /foods.json
  def index
    # @foods = Food.all.order('created_at DESC').page params[:page]

    @foods = Food.feed(current_user.following_ids, current_user.id)
      .order_by_time
  end

  # GET /foods/1
  # GET /foods/1.json
  def show
    @comments = @food.comments
  end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit
  end

  # POST /foods
  # POST /foods.json
  def create
    @food = current_user.foods.new food_params

    respond_to do |format|
      if @food.save
        flash[:success] = 'Food was successfully created.'
        format.html { redirect_to @food }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foods/1
  # PATCH/PUT /foods/1.json
  def update
    if params[:food][:picture].nil? && params[:food][:picture_flag] == '2'
      @errors = "Can't be blank"
      render :edit
    else
      respond_to do |format|
        if @food.update(food_params)
          flash[:success] = 'Food was successfully updated.'
          format.html { redirect_to @food }
          format.json { render :show, status: :ok, location: @food }
        else
          format.html { render :edit }
          format.json { render json: @food.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /foods/1
  # DELETE /foods/1.json
  def destroy
    @food.destroy
    respond_to do |format|
      flash[:success] = 'Food was successfully destroyed.'
      format.html { redirect_to foods_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_params
      params.require(:food).permit(:user_id, :name, :caption, :address, :picture)
    end
end
