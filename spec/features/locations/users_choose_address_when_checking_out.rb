require 'rails_helper'

RSpec.describe 'As a registered default user' do
  context 'When checking out' do

    before :each do
      @user = User.create!(email: "test@test.com", password: "pass", role: 0, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")
      @location_1 = @user.locations.create!(name: 'home', address: '123 Test St', city: "Testville", state: "Test", zip: "01234" )
      @location_2 = @user.locations.create!(name: 'work', address: '123 work St', city: "Testville", state: "Test", zip: "01234" )
      @location_3 = @user.locations.create!(name: 'moms', address: '123 moms St', city: "Testville", state: "Test", zip: "01234" )
      merchant_1 = create(:user)
      @item_1 = create(:item, user: merchant_1)
      @item_2 = create(:item, user: merchant_1)
      @item_3 = create(:item, user: merchant_1)

      visit login_path

      fill_in "Email", with: 'test@test.com'
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

    it 'allows me to choose my address to ship to' do
      
    end

  end
end
