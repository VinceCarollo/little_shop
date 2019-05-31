class UsersController < ApplicationController

  def new
    @user = User.new
    @location = Location.new
  end

  def create
    @user = User.new(user_params)
    @location = Location.new(location_params)
    @location.name = "home"
    @location.user = @user
    if password_confirmation != true
      flash.now[:notice] = "Those passwords don't match."
      render :new
    elsif @user.save && @location.save
      session[:user_id] = @user.id
      flash[:notice] = "You are now registered and logged in."
      redirect_to profile_path
    else
      render :new
    end
  end

  private

  def password_confirmation
    if params["user"]["password"] == params["user"]["confirm_password"]
      true
    else
      false
    end
  end

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
  end

  def location_params
    params.require(:user).permit(:address, :city, :state, :zip)
  end

end
