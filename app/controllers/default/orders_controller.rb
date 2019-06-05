class Default::OrdersController < Default::BaseController

  def update
    @order = Order.find(params[:id])
    @user = current_user
    @location = Location.find_by(user: @user, name: params[:location])
    if used_in_completed_order?(@user, @order.location)
      flash.notice = "This Order's address cannot be changed"
      redirect_to(profile_order_path(@order))
    else
      @order.location = @location
      @order.save
      flash.notice = "This order's address was successfully changed"
      redirect_to(profile_order_path(@order))
    end
  end

  def index
    @user = current_user
    @orders = @user.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @user = current_user
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
