require 'rails_helper'

RSpec.describe 'As a user with an order in the system' do
  describe 'while looking at my order show page' do

    before :each do
      @user_1 = User.create!(email: "test1@test.com", password: "pass", role: 0, active: true, name: "Testy McTesterson1")
      @user_1_home = @user_1.locations.create!(name: 'home', address: '123 Test St', city: "Testville", state: "Test", zip: "01234" )
      @user_1_work = @user_1.locations.create!(name: 'work', address: '123 work St', city: "Testville", state: "Test", zip: "01234" )
      @user_1_moms = @user_1.locations.create!(name: 'moms', address: '123 moms St', city: "Testville", state: "Test", zip: "01234" )
      merchant_1 = create(:user, role: 1)
      @item_1 = create(:item, user: merchant_1)
      @order = Order.create!(user: @user_1, status: 1, location: @user_1_home)
      @oi = OrderItem.create!(item: @item_1, order: @order, quantity: 1, price: @item_1.price, fulfilled: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    end

    it 'can change order location' do
      visit profile_order_path(@order)

      find(:css, "#location_work[value='work']").click

      click_button "Change This Orders Address"
      expect(current_path).to eq(profile_order_path(@order))
      expect(page).to have_content("This order's address was successfully changed")
      expect(page).to have_content("Address Used: work")
    end

    it 'cant change order location if order is pending or shipped' do
      @order.status = 0
      @order.save
      @order.reload
      
      visit profile_order_path(@order)

      find(:css, "#location_work[value='work']").click

      click_button "Change This Orders Address"
      expect(current_path).to eq(profile_order_path(@order))
      expect(page).to have_content("This Order's address cannot be changed")
      expect(page).to have_content("Address Used: home")

      @order.status = 2
      @order.save
      @order.reload

      visit profile_order_path(@order)

      find(:css, "#location_work[value='work']").click

      click_button "Change This Orders Address"
      expect(current_path).to eq(profile_order_path(@order))
      expect(page).to have_content("This Order's address cannot be changed")
      expect(page).to have_content("Address Used: home")

      @order.status = 3
      @order.save
      @order.reload

      visit profile_order_path(@order)

      find(:css, "#location_work[value='work']").click

      click_button "Change This Orders Address"
      expect(current_path).to eq(profile_order_path(@order))
      expect(page).to have_content("This Order's address cannot be changed")
      expect(page).to have_content("Address Used: home")
    end

  end
end
