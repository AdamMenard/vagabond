class UsersController < ApplicationController

  # => not being served currently. Keeping for future use
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    redirect_to user_path(@user.id) # => goes to user's profile pager AFTER account creation
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    user = User.find_by_id(params[:id])
    user.update_attributes(user_params)
    if user.save
      redirect_to user_path(user)
      flash[:notice] = "Profile updated!"
    else
      flash[:error] = "Error saving update"
      redirect_to edit_user_path
    end
  end

  # => private methods
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :current_city, :email, :password)
  end

end
