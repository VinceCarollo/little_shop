require 'rails_helper'

RSpec.describe 'As a Registered User', type: :feature do
  include ActiveSupport::Testing::TimeHelpers

  describe 'When I visit of my Orders show pages' do
    before :each do
      @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 0, active: true, name: "Testy McTesterson")

      @merchant_1 = create(:user)
      @merchant_2 = create(:user)

      @item_1 = create(:item, user: @merchant_1)
      @item_2 = create(:item, user: @merchant_1)
      @item_3 = create(:item, user: @merchant_2)

      travel_to Time.zone.local(2019, 04, 11, 8, 00, 00)
      @order_1 = create(:order, user: @user)
      travel_to Time.zone.local(2019, 04, 12, 8, 00, 00)
      @order_1.update(status: 2)
      travel_back

      @order_item_1 = create(:order_item, order: @order_1, item: @item_1)
      @order_item_2 = create(:order_item, order: @order_1, item: @item_2)
      @order_item_3 = create(:order_item, order: @order_1, item: @item_3)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'Has all the information for the Order' do
      visit profile_order_path(@order_1)

      expect(page).to have_content("Date Made: #{@order_1.date_made}")
      expect(page).to have_content("Last Updated: #{@order_1.last_updated}")
      expect(page).to have_content("Current Status: #{@order_1.status.capitalize}")

      within("#order-item-#{@order_item_1.id}") do
        expect(page).to have_content("#{@item_1.name}")
        expect(page).to have_content("#{@item_1.description}")
        expect(page).to have_css("img[src*='#{@item_1.image}']")
        expect(page).to have_content("Quantity: #{@order_item_1.quantity}")
        expect(page).to have_content("Subtotal: $#{@order_item_1.sub_total}")
      end

      within("#order-item-#{@order_item_2.id}") do
        expect(page).to have_content("#{@item_2.name}")
        expect(page).to have_content("#{@item_2.description}")
        expect(page).to have_css("img[src*='#{@item_2.image}']")
        expect(page).to have_content("Quantity: #{@order_item_2.quantity}")
        expect(page).to have_content("Subtotal: $#{@order_item_2.sub_total}")
      end

      within("#order-item-#{@order_item_3.id}") do
        expect(page).to have_content("#{@item_3.name}")
        expect(page).to have_content("#{@item_3.description}")
        expect(page).to have_css("img[src*='#{@item_3.image}']")
        expect(page).to have_content("Quantity: #{@order_item_3.quantity}")
        expect(page).to have_content("Subtotal: $#{@order_item_3.sub_total}")
      end

      expect(page).to have_content("Number of Items: #{@order_1.item_count}")
      expect(page).to have_content("Grand Total: $#{@order_1.grand_total}")
    end

    it 'I can cancel the order if it is still pending' do
      @order_1.update!(status: :pending)
      @item_2.update!(inventory: 3)
      @order_item_2.update!(fulfilled: true)
      @item_2.reload
      @order_item_2.reload
      expect(@item_2.inventory).to eq(2)

      visit profile_order_path(@order_1)

      expect(page).to have_content("Current Status: Pending")
      expect(page).to have_button("Cancel Order")

      click_button "Cancel Order"

      @order_item_1.reload
      @order_item_2.reload
      @order_item_3.reload
      expect(@order_item_1.fulfilled).to be false
      expect(@order_item_2.fulfilled).to be false
      expect(@order_item_3.fulfilled).to be false

      @item_2.reload
      expect(@item_2.inventory).to eq(3)

      expect(current_path).to eq(profile_orders_path)

      expect(page).to have_content("#{@order_1.id} has been cancelled.")

      within("#order-#{@order_1.id}") do
        expect(page).to have_content("Current Status: Cancelled")
      end
    end

    it 'Should have a disabled cancel button if the order is not pending' do
      visit profile_order_path(@order_1)

      expect(page).to have_content("Current Status: Shipped")
      expect(page).to have_button("Cancel Order", disabled: true)
      expect(page).to have_content("You can only cancel orders that are pending!")
    end
  end

  describe 'when looking at one of my orders' do
    include ActionView::Helpers::NumberHelper
    before :each do
      @user_1 = User.create!(email: "test1@test.com", password: "pass", role: 0, active: true, name: "Testy McTesterson1")
      @user_1_home = @user_1.locations.create!(name: 'home', address: '123 Test St', city: "Testville", state: "home", zip: "home" )
      @user_1_work = @user_1.locations.create!(name: 'work', address: '123 work St', city: "worksvill", state: "work", zip: "work" )
      @merchant = User.create!(name: 'Merchant', email: 'merc@test.com', password: 'pass', role: 1)
      @coupon = @merchant.coupons.create!(name: '20 Off', code: '20OFF', amount_off: 20)
      @order_1 = Order.create(user: @user_1, status: 1, location: @user_1_work)
      @item_1 = create(:item, user: @merchant)
      @item_2 = create(:item, user: @merchant)
      @item_3 = create(:item, user: @merchant)

      visit login_path

      fill_in "Email", with: 'test1@test.com'
      fill_in "Password", with: 'pass'

      click_button 'Login'

      click_link "Cheese"

      within "#item-#{@item_1.id}" do
        click_link "Add To Cart"
      end

      within "#item-#{@item_2.id}" do
        click_link "Add To Cart"
        click_link "Add To Cart"
      end

      click_link "Cart"

      fill_in "code", with: '20OFF'
      click_button "Add Coupon"
      click_button "Checkout"
    end

    it 'shows the address used on that order' do
      visit profile_order_path(@order_1)
      expect(page).to have_content("Address Used: #{@user_1_work.name}")
      expect(page).to have_content(@user_1_work.address)
      expect(page).to have_content(@user_1_work.city)
      expect(page).to have_content(@user_1_work.state)
      expect(page).to have_content(@user_1_work.zip)
    end

    it 'shows the coupon used on order' do
      order = Order.last
      total = @item_2.price * 2 + @item_1.price - @coupon.amount_off

      visit profile_order_path(order)

      expect(page).to have_content("Coupon Used: #{@coupon.name}")
      expect(page).to have_content("Amount Discounted: #{number_to_currency(@coupon.amount_off)}")
      expect(page).to have_content("Grand Total: #{number_to_currency(total)}")
    end
  end

end
