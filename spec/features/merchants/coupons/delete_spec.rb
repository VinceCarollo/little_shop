require 'rails_helper'

RSpec.describe "As a merchant" do
  describe 'viewing my coupons' do
    before :each do
      @merchant = User.create!(name: "Merchant", email: "merchant@test.com", password: 'pass', role: 1)
      @five_off = @merchant.coupons.create!(name: "Five Off", code: "5OFF", amount_off: 5)
      @two_off = @merchant.coupons.create!(name: "Two Off", code: "2OFF", amount_off: 2)
      @buyer = create(:user, name: "buyer")
      @buyer_1_address = @buyer.locations.create!(name: 'home', address: '123', city: 'Testville', state: 'mo', zip: '12345')
      @order = Order.create!(user: @buyer, status: 1, location: @buyer_1_address, coupon: @two_off)

      visit login_path
      fill_in 'Email', with: "merchant@test.com"
      fill_in 'Password', with: 'pass'

      click_button "Login"
      click_link "View My Coupons"
    end

    it "can delete coupons" do

      within "#coupon-#{@five_off.id}" do
        click_link "Delete #{@five_off.name}"
      end
      expect(current_path).to eq(dashboard_coupons_path)
      expect(page).to_not have_content(@five_off.name)
      expect(page).to_not have_content(@five_off.code)
    end

    it "cant delete coupons that have been used on an order" do

      within "#coupon-#{@two_off.id}" do
        click_link "Delete #{@two_off.name}"
      end

      expect(current_path).to eq(dashboard_coupons_path)

      within "#coupon-#{@two_off.id}" do
        expect(page).to have_content(@two_off.name)
        expect(page).to have_content(@two_off.code)
      end
      expect(page).to have_content("That coupon is being used for an order and cannot be deleted")
    end

  end
end
