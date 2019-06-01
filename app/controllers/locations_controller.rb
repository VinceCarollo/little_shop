class LocationsController < ApplicationController

  def destroy
    user = User.find(params[:user_id])
    location = Location.find(params[:id])
    if order_check(user, location)
      flash.notice = "Your #{location.name} address is being used for a current order and cannot be deleted"
    else
      location.destroy
      redirect_to profile_path
    end
  end

  private

  def order_check(user, location)
    orders_shipped_to = user.orders.map{|order| order.location_id}
    orders_shipped_to.include?(location.id)
  end
end
