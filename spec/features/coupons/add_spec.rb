require 'rails_helper'

RSpec.describe 'As a registered user while viewing my cart' do
  before :each do
    @merchant_1 = User.create!(name: "Merchant1", email: "merchant1@test.com", password: 'pass', role: 1)
    @merchant_2 = User.create!(name: "Merchant2", email: "merchant2@test.com", password: 'pass', role: 1)
    @buyer_1 = User.create!(name: "Buyer1", email: "Buyer1@test.com", password: 'pass')
    @buyer_1.locations.create!(name: 'home', address: '123 test rd', city: 'testville', state: "CO", zip: '12345')
    @buyer_2 = User.create!(name: "Buyer2", email: "Buyer2@test.com", password: 'pass')
    @buyer_2.locations.create!(name: 'home', address: '123 test rd', city: 'testville', state: "CO", zip: '12345')
    @merchant_1_coup_1 = @merchant_1.coupons.create!(name: "Five Off", code: "5OFF", amount_off: 5)
    @merchant_1_coup_2 = @merchant_1.coupons.create!(name: "Two Off", code: "2OFF", amount_off: 2)
    @merchant_2_coup_1 = @merchant_2.coupons.create!(name: "One Off", code: "1OFF", amount_off: 1)
    @item_1 = create(:item, name: "Item 1", user: @merchant_1)
    @item_2 = create(:item, name: "Item 1", user: @merchant_1)
    @item_3 = create(:item, name: "Item 1", user: @merchant_2)

    visit login_path

    fill_in "Email", with: "Buyer1@test.com"
    fill_in "password", with: "pass"
    click_button "Login"
  end

  it 'can add a coupon code to the pending order' do
    visit items_path
    within "#item-#{@item_1.id}" do
      click_link "Add To Cart"
    end

    visit carts_path

    fill_in "Coupon Code", with: "5OFF"
    click_button "Add Coupon"

    expect(current_path).to eq(carts_path)
    expect(page).to have_content("The coupon #{@merchant_1_coup_1.name} has been added to your order")
    expect(page).to have_content("Discounted: $#{@item_1.price - @merchant_1_coup_1.amount_off}")
  end

  it 'doesnt allow coupons that dont exist' do
    visit items_path
    within "#item-#{@item_1.id}" do
      click_link "Add To Cart"
    end

    visit carts_path

    fill_in "Coupon Code", with: "some"
    click_button "Add Coupon"

    expect(current_path).to eq(carts_path)
    expect(page).to have_content("Invalid Coupon")
  end

  it 'allows only one coupon' do
    visit items_path
    within "#item-#{@item_1.id}" do
      click_link "Add To Cart"
    end

    visit carts_path

    fill_in "Coupon Code", with: "2OFF"
    click_button "Add Coupon"

    fill_in "Coupon Code", with: "5OFF"
    click_button "Add Coupon"

    expect(current_path).to eq(carts_path)
    expect(page).to have_content("The coupon #{@merchant_1_coup_1.name} has been added to your order")
    expect(page).to have_content("Discounted: $#{@item_1.price - @merchant_1_coup_1.amount_off}")
  end

  it 'only applies coupon to that merchants items' do
    visit items_path

    within "#item-#{@item_3.id}" do
      click_link "Add To Cart"
    end

    visit carts_path

    fill_in "Coupon Code", with: "5OFF"
    click_button "Add Coupon"

    expect(page).to have_content("Invalid Coupon")
    expect(page).to_not have_content("Discounted:")
  end
end
