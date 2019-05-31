require 'rails_helper'

RSpec.describe 'As a registered default user' do
  context 'When checking out' do

    before :each do
      @user_1 = User.create!(email: "test1@test.com", password: "pass", role: 0, active: true, name: "Testy McTesterson1")
      @user_2 = User.create!(email: "test2@test.com", password: "pass", role: 0, active: true, name: "Testy McTesterson2")
      @user_1_home = @user_1.locations.create!(name: 'home', address: '123 Test St', city: "Testville", state: "Test", zip: "01234" )
      @user_1_work = @user_1.locations.create!(name: 'work', address: '123 work St', city: "Testville", state: "Test", zip: "01234" )
      @user_1_moms = @user_1.locations.create!(name: 'moms', address: '123 moms St', city: "Testville", state: "Test", zip: "01234" )
      @user_2_home = @user_2.locations.create!(name: 'home', address: '123 moms St', city: "Testville", state: "Test", zip: "01234" )
      merchant_1 = create(:user, role: 1)
      @item_1 = create(:item, user: merchant_1)
      @item_2 = create(:item, user: merchant_1)
      @item_3 = create(:item, user: merchant_1)

      visit login_path

      fill_in "Email", with: 'test1@test.com'
      fill_in "Password", with: 'pass'
      click_button 'Login'

      visit items_path

      within "#item-#{@item_1.id}" do
        click_link "Add To Cart"
      end

      within "#item-#{@item_2.id}" do
        click_link "Add To Cart"
        click_link "Add To Cart"
      end

      within "#item-#{@item_3.id}" do
        click_link "Add To Cart"
        click_link "Add To Cart"
        click_link "Add To Cart"
      end

      visit carts_path
    end

    it 'adds chosen location to the order' do
      find(:css, "#location_work[value='work']").click

      click_button 'Checkout'

      order = Order.last

      expect(order.location).to eq(@user_1_work)
      expect(order.user).to eq(@user_1)
    end

  end
end
