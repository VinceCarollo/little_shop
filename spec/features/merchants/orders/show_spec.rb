require 'rails_helper'

RSpec.describe 'As a merchant', type: :feature do
  describe 'When I visit an order show page from my Dasboard' do
    before :each do
      @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 1, active: true, name: "Testy McTesterson")
      @user_location = @user.locations.create!(name: 'home', address: '123 Test St',state: 'Testville', city: 'Test', zip: '01234')

      @merchant_1 = create(:user, role: 1)
      @merchant_2 = create(:user, role: 1)

      @item_1 = create(:item, user: @merchant_1)
      @item_2 = create(:item, user: @merchant_1)
      @item_3 = create(:item, user: @merchant_2)

      @order = create(:order, user: @user, location: @user_location)

      @order_item_1 = create(:order_item, order: @order, item: @item_1)
      @order_item_2 = create(:order_item, order: @order, item: @item_2)
      @order_item_3 = create(:order_item, order: @order, item: @item_3)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
    end

    it 'Displays the Orders User information' do
      visit dashboard_order_path(@order)

      expect(page).to have_content("Name: Testy McTesterson")
      expect(page).to have_content("Order Location: 123 Test St, Test, Testville, 01234")
    end

    it 'Displays only my Items in the Order' do
      visit dashboard_order_path(@order)

      within("#item-#{@item_1.id}") do
        expect(page).to have_link(@item_1.name, href: item_path(@item_1))
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
        expect(page).to have_content(@item_1.price)
        expect(page).to have_content(@order_item_1.quantity)
      end

      within("#item-#{@item_2.id}") do
        expect(page).to have_link(@item_2.name, href: item_path(@item_2))
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
        expect(page).to have_content(@item_2.price)
        expect(page).to have_content(@order_item_2.quantity)
      end

      expect(page).to_not have_css("#item-#{@item_3.id}")
    end

    it 'Should have a Fulfill button on unfulfilled items, and a disabled button on fulfilled items' do
      @order_item_2.update(fulfilled: true)
      @order_item_2.reload
      visit dashboard_order_path(@order)

      within("#item-#{@item_1.id}") do
        expect(page).to have_button("Fulfill Item")
      end

      within("#item-#{@item_2.id}") do
        expect(page).to have_button("Fulfill Item", disabled: true)
        expect(page).to have_content("You have already fulfilled this item!")
      end
    end

    it 'Should not allow me to fulfill an item if the inventory is too low' do
      @order_item_2.update(quantity: 112)
      @order_item_2.reload
      visit dashboard_order_path(@order)

      within("#item-#{@item_2.id}") do
        expect(page).to have_button("Fulfill Item", disabled: true)
        expect(page).to have_content("You do not have enough inventory to fulfill this item!")
      end
    end

    it 'When I fulfill the Item, I see a flash notice, can no longer fulfill the Item, and the Item inventory is reduced' do
      original_inventory = @item_1.inventory
      visit dashboard_order_path(@order)

      within("#item-#{@item_1.id}") do
        click_button "Fulfill Item"
      end

      @item_1.reload

      expect(current_path).to eq(dashboard_order_path(@order))

      expect(page).to have_content("Item '#{@item_1.name}' fulfilled.")

      within("#item-#{@item_1.id}") do
        expect(page).to have_button("Fulfill Item", disabled: true)
        expect(page).to have_content("You have already fulfilled this item!")
      end

      expect(@item_1.inventory).to eq(original_inventory - @order_item_1.quantity)
    end
  end
end

describe 'As a merchant' do
  describe 'When I visit an order show page from my Dasboard' do
    include ActionView::Helpers::NumberHelper

    before :each do
      @user_1 = User.create!(email: "test1@example.com", password: "pass", role: 0, active: true, name: "Testy McTesterson1")
      @user_1_home = @user_1.locations.create!(name: 'home', address: '123 Test St', city: "Testville", state: "home", zip: "home" )
      @user_1_work = @user_1.locations.create!(name: 'work', address: '123 work St', city: "worksvill", state: "work", zip: "work" )
      @merchant = User.create!(name: 'Merchant', email: 'merc@example.com', password: 'pass', role: 1)
      @merchant.locations.create!(name: 'home', address: '123 test', city: 'KC', state: 'mo', zip: '12345')
      @coupon = @merchant.coupons.create!(name: '10 Off', code: '10OFF', amount_off: 10)
      @order_1 = Order.create(user: @user_1, status: 1, location: @user_1_work)
      @item_1 = create(:item, user: @merchant)
      @item_2 = create(:item, user: @merchant)
      @item_3 = create(:item, user: @merchant)

      visit login_path

      fill_in "Email", with: 'test1@example.com'
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

      fill_in "code", with: '10OFF'
      click_button "Add Coupon"
      click_button "Checkout"
      click_link "Logout"
      click_link "Login"

      fill_in "Email", with: 'merc@example.com'
      fill_in "Password", with: 'pass'
      click_button "Login"
    end

    it 'shows coupon used on order' do
      order = Order.last
      coupon = Coupon.last
      visit dashboard_order_path(order)

      expect(page).to have_content("Coupon Used: #{coupon.name}")
      expect(page).to have_content("Amount Discounted: #{number_to_currency(coupon.amount_off)}")
    end
  end
end
