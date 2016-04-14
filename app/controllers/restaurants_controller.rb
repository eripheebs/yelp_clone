class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @user = current_user
    @restaurant = @user.restaurants.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    if user_is_owner?
      flash[:notice] = 'You cannot edit this restaurant'
      redirect_to restaurants_path
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to restaurants_path
  end

  def destroy
    if user_is_owner?
      flash[:notice] = 'You cannot delete this restaurant'
    else
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
    end
    redirect_to restaurants_path
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def user_is_owner?
    @restaurant = Restaurant.find(params[:id])
    @user = current_user
    @user.id != @restaurant.user_id
  end
end
