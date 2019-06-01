require 'rails_helper'

RSpec.describe 'As a registered user' do

  context 'if I delete all of my addresses' do

    before :each do
      @user_1 = User.create!(email: "test1@test.com", password: "pass", role: 0, active: true, name: "Testy McTesterson1")
      @user_1_home = @user_1.locations.create!(name: 'home', address: '123 Test St', city: "Testville", state: "home", zip: "home" )
      @user_1_work = @user_1.locations.create!(name: 'work', address: '123 work St', city: "worksvill", state: "work", zip: "work" )
      @order_1 = Order.create(user: @user_1, status: 1, location: @user_1_work)
      @order_2 = Order.create(user: @user_1, status: 1, location: @user_1_moms)
      merchant_1 = create(:user, role: 1)
      @item_1 = create(:item, user: merchant_1)

      visit login_path

      fill_in "Email", with: 'test1@test.com'
      fill_in "Password", with: 'pass'

      click_button 'Login'

      visit items_path

      within "#item-#{@item_1.id}" do
        click_link "Add To Cart"
      end

      visit profile_path

      within "#location-#{@user_1_home.id}" do
        click_link "Delete #{@user_1_home.name.capitalize}"
      end

      within "#location-#{@user_1_work.id}" do
        click_link "Delete #{@user_1_work.name.capitalize}"
      end
    end

    it 'wont allow a checkout' do
      visit carts_path

      expect(page).to_not have_button("Checkout")
      expect(page).to_not have_link("Clear Cart")
      expect(page).to have_content("You must make an address before checking out")
      expect(page).to have_link("Create Address")
    end

  end

end
