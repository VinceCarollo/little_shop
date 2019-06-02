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
    if too_many_coupons?
      flash.notice = "Sorry, you can have a max of 5 coupons in the system"
      redirect_to dashboard_coupons_path
    elsif @coupon.save
      flash.notice = "Your Coupon has been created"
      redirect_to dashboard_coupons_path
    else
      render :new
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :code, :amount_off)
  end

  def too_many_coupons?
    @user.coupons.length >= 5
  end
end
