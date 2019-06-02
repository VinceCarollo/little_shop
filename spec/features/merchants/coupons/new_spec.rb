require "rails_helper"

RSpec.describe "As a merchant adding to my coupons" do
  include ActionView::Helpers::NumberHelper

  before :each do
    @merchant = User.create!(name: "Merchant", email: "merchant@test.com", password: 'pass', role: 1)
    @five_off = @merchant.coupons.create!(name: "Five Off", code: "5OFF", amount_off: 5)
    @two_off = @merchant.coupons.create!(name: "Two Off", code: "2OFF", amount_off: 2)

    visit login_path
    fill_in 'Email', with: "merchant@test.com"
    fill_in 'Password', with: 'pass'

    click_button "Login"
    click_link "View My Coupons"
    click_link "Add a Coupon"
  end

  it 'allows me to create a new coupon' do

    fill_in "Name", with: "One Off"
    fill_in "Code", with: "1OFF"
    fill_in "Amount off", with: '1'

    click_button "Create Coupon"
    expect(current_path).to eq(dashboard_coupons_path)

    coupon = Coupon.last
    expect(@merchant.coupons).to include(coupon)

    within "#coupon-#{coupon.id}" do
      expect(page).to have_content(coupon.name)
      expect(page).to have_content(coupon.code)
      expect(page).to have_content(number_to_currency(coupon.amount_off))
    end
  end

  it 'doesnt allow new coupon creation if missing fields' do

    fill_in "Code", with: "1OFF"
    fill_in "Amount off", with: '1'

    click_button "Create Coupon"

    expect(current_path).to eq(dashboard_coupons_path)
    expect(page).to have_content("Name can't be blank")
  end

  it 'doesnt allow new coupon creation if current merchant has 5 coupons already' do
    coupon_3 = @merchant.coupons.create!(name: "Coupon 3", code: "3COUP", amount_off: 1)
    coupon_4 = @merchant.coupons.create!(name: "Coupon 4", code: "4COUP", amount_off: 1)
    coupon_5 = @merchant.coupons.create!(name: "Coupon 5", code: "5COUP", amount_off: 1)

    fill_in "Name", with: "One Off"
    fill_in "Code", with: "1OFF"
    fill_in "Amount off", with: '1'

    click_button "Create Coupon"

    expect(current_path).to eq(dashboard_coupons_path)

    expect(Coupon.last.name).to_not eq("One Off")
    expect(Coupon.last.code).to_not eq("1OFF")
    expect(page).to have_content("Sorry, you can have a max of 5 coupons in the system")
  end

  it 'doesnt allow new coupon creation if amount off is not integer' do

    fill_in "Name", with: "One Off"
    fill_in "Code", with: "1OFF"
    fill_in "Amount off", with: 'not integer'

    click_button "Create Coupon"

    expect(current_path).to eq(dashboard_coupons_path)

    expect(Coupon.last.name).to_not eq("One Off")
    expect(Coupon.last.code).to_not eq("1OFF")
    expect(page).to have_content("Amount off is not a number")
  end

end
