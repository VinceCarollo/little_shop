require 'rails_helper'

RSpec.describe 'As a merchant viewing my coupons' do

  before :each do
    @merchant = User.create!(name: "Merchant", email: "merchant@test.com", password: 'pass', role: 1)
    @five_off = @merchant.coupons.create!(name: "Five Off", code: "5OFF", amount_off: 5)
    @two_off = @merchant.coupons.create!(name: "Two Off", code: "2OFF", amount_off: 2)

    visit login_path
    fill_in 'Email', with: "merchant@test.com"
    fill_in 'Password', with: 'pass'

    click_button "Login"
    click_link "View My Coupons"
  end

  it 'can edit an existing coupon' do

    within "#coupon-#{@two_off.id}" do
      click_link "Edit #{@two_off.name}"
    end

    fill_in "Name", with: "Ten Off"
    fill_in "Code", with: "10OFF"
    fill_in "Amount off", with: "10"

    click_button "Update Coupon"

    within "#coupon-#{@two_off.id}" do
      expect(page).to have_content("Ten Off")
      expect(page).to have_content("10OFF")
      expect(page).to have_content("10")
    end

    expect(@merchant.coupons).to include(@two_off)
    expect(current_path).to eq(dashboard_coupons_path)
    expect(page).to have_content("Successfully Updated")
  end

  it 'can disable and enable coupons' do

    within "#coupon-#{@two_off.id}" do
      click_link "Disable #{@two_off.name}"
    end

    expect(current_path).to eq(dashboard_coupons_path)

    within "#coupon-#{@two_off.id}" do
      expect(page).to have_content("Active: false")
    end

    within "#coupon-#{@two_off.id}" do
      click_link "Enable #{@two_off.name}"
    end

    expect(current_path).to eq(dashboard_coupons_path)

    within "#coupon-#{@two_off.id}" do
      expect(page).to have_content("Active: true")
    end

  end

  it 'can delete a coupon' do

    within "#coupon-#{@two_off.id}" do
      click_link "Delete #{@two_off.name}"
    end

    expect(current_path).to eq(dashboard_coupons_path)

    expect(page).to_not have_content(@two_off.name)
    expect(page).to_not have_content(@two_off.code)
  end

  it 'cant create coupon with string as amount' do

    within "#coupon-#{@two_off.id}" do
      click_link "Edit #{@two_off.name}"
    end

    fill_in "Amount off", with: "dsgs"

    click_button "Update Coupon"

    expect(current_path).to eq(dashboard_coupon_path(@two_off))
    expect(page).to have_content("Amount off is not a number")
  end

end
