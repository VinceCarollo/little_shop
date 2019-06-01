class LocationsController < ApplicationController

  def destroy
    user = User.find(params[:user_id])
    location = Location.find(params[:id])
    if used_in_completed_order?(user, location)
      flash.notice = "Your #{location.name} address is being used for a current order and cannot be deleted"
      redirect_to profile_path
    else
      location.destroy
      redirect_to profile_path
    end
  end

  private

  def used_in_completed_order?(user, location)
    used = false
    user.orders.each do |order|
      if order.location == location
        used = order.status == "shipped" || order.status == "packaged"
      end
    end
    used
  end
end
