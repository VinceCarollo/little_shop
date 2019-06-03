class Default::OrdersController < Default::BaseController
  def index
    @user = current_user
    @orders = @user.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def destroy
    @order = Order.find(params[:id])
    @order.update(status: :cancelled)
    @order.order_items.each do |order_item|
      order_item.update(fulfilled: false)
    end
    flash[:notice] = "#{@order.id} has been cancelled."

    redirect_to profile_orders_path
  end

  def create
    location = Location.find_by(user_id: current_user.id, name: params[:location])
    cart = Cart.new(session[:cart])
    if cart.contents.empty?
      flash.notice = "Your Cart is Empty"
      redirect_to carts_path
    elsif session[:coupon_id]
      coupon = Coupon.find(session[:coupon_id])
      cart.create_order(current_user.id, location, coupon)
      session[:cart] = {}
      session[:coupon_id] = nil
      flash.notice = "Your Order Was Created"
      redirect_to profile_orders_path
    else
      cart.create_order(current_user.id, location)
      session[:cart] = {}
      flash.notice = "Your Order Was Created"
      redirect_to profile_orders_path
    end
  end
end
