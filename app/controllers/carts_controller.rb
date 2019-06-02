class CartsController < ApplicationController

  before_action :cart_user?

  def show
    @user = current_user
    @cart = Cart.new(session[:cart])
    @cart_items = @cart.ids_to_items
    @cart_price_total = @cart.total_price
    @discounted_total = @cart.discounted_price(session[:coupon_id])
  end

  def update
    request = params[:request]
    item_id = params[:id]
    cart = session[:cart]
    if request == "remove_item"
      cart.delete(item_id)
    elsif request == "add_one"
      cart[item_id] += 1
    elsif request == "remove_one"
      cart[item_id] -= 1
      cart.delete(item_id) if cart[item_id] == 0
    end

    redirect_to carts_path
  end

  def add
    item = Item.find(params[:item_id])
    cart = Cart.new(session[:cart])
    cart.add(item.id)
    session[:cart] = cart.contents
    flash.notice = "#{item.name} has been added to your cart"
    redirect_to items_path
  end

  def clear
    session[:cart] = {}
    session[:coupon_id] = nil
    redirect_to carts_path
  end

  private

  def cart_user?
    render file: "/public/404" unless !current_admin? && !current_merchant?
  end
end
