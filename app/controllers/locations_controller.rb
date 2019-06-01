class LocationsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @location = Location.new
  end

  def create
    params[:location][:name] = params[:location][:name].downcase
    @location = Location.new(location_params)
    @user = User.find(params[:user_id])
    @location.user_id = @user.id
    if @location.save
      flash.notice = "Address #{@location.name} has been created"
      redirect_to profile_path
    else
      render :new
    end
  end

  def destroy
    user = User.find(params[:user_id])
    location = Location.find(params[:id])
    if used_in_completed_order?(user, location)
      flash.notice = "Your #{location.name} address is being used for a current order and cannot be deleted"
      redirect_to profile_path
    else
      order_check(user, location) #deletes order even if on pending or canceled order
      location.destroy
      redirect_to profile_path
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @location = Location.find(params[:id])
    if used_in_completed_order?(@user, @location)
      flash.notice = "Your #{@location.name} address is being used for a current order and cannot be edited"
      redirect_to profile_path
    end
  end

  def update
    params[:location][:name].downcase!
    location = Location.update(params[:id], location_params)
    location.save
    redirect_to profile_path
  end

  private

  def location_params
    params.require(:location).permit(:name, :address, :city, :state, :zip)
  end

  def used_in_completed_order?(user, location)
    used = false
    user.orders.each do |order|
      if order.location == location
        used = order.status == "shipped" || order.status == "packaged"
      end
    end
    used
  end

  def order_check(user, location)
    order = user.orders.find_by(location: location)
    if order
      order.update(location_id: nil)
      order.save
    end
  end
end
