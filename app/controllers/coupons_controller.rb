class CouponsController < ApplicationController

  def add
    coupon = Coupon.find_by(code: params[:code])
    if valid?(coupon)
      session[:coupon_id] = coupon.id
      flash.notice = "The coupon #{coupon.name} has been added to your order"
      redirect_to carts_path
    else
      flash.notice = "Invalid Coupon"
      redirect_to carts_path
    end
  end

  private

  def valid?(coupon)
    cart_items = Cart.new(session[:cart]).ids_to_items.keys
    seller_ids = cart_items.map{|item| item.user_id}.uniq
    coupon && seller_ids.include?(coupon.user_id) && coupon.active
  end
end
