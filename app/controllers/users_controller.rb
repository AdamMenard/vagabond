class UsersController < ApplicationController

  # => not being served currently. Keeping for future use
  # def index
  #   @users = User.all
  # end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      login(@user) # logs the user in after they create an account
      redirect_to @user
      flash[:success] = "Account created!"
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      redirect_to new_user_path # goes to user show page for logging in user
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    @post = Post.find_by(params[:user_id])
    @current_user ||= User.find_by_id(session[:user_id])
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
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to edit_user_path
    end
  end

  def destroy
    user = User.find_by_id(params[:id])
    user.destroy
    redirect_to root_path
    flash[:success] = "Account deleted"
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :current_city, :email, :password)
  end

end
