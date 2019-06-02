class Merchants::CouponsController < Merchants::BaseController

  def index
    @user = current_user
  end

  def new
    @user = current_user
    @coupon = Coupon.new
  end

  def create
    @user = current_user
    @coupon = @user.coupons.new(coupon_params)
    if @user.coupons.length > 5
      flash.notice = "Sorry, you can have a max of 5 coupons in the system"
      redirect_to dashboard_coupons_path
    elsif @coupon.save
      flash.notice = "Your Coupon has been created"
      redirect_to dashboard_coupons_path
    else
      render :new
    end
  end

  def edit
    @coupon = Coupon.find(params[:id])
  end

  def update
    @coupon = Coupon.find(params[:id])
    @coupon.update(coupon_params)
    if @coupon.save
      flash.notice = "Successfully Updated"
      redirect_to dashboard_coupons_path
    else
      render :new
    end
  end

  def disable
    coupon = Coupon.find(params[:id])
    coupon.update(active: false)
    coupon.save
    redirect_to dashboard_coupons_path
  end

  def enable
    coupon = Coupon.find(params[:id])
    coupon.update(active: true)
    coupon.save
    redirect_to dashboard_coupons_path
  end

  def destroy
    Coupon.destroy(params[:id])
    redirect_to dashboard_coupons_path
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :code, :amount_off)
  end
end
