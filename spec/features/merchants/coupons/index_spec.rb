require "rails_helper"

RSpec.describe 'As a merchant on my dashboard' do
  describe 'when I click on view my coupons' do
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
    end

    it 'shows all of my coupons' do

      within "#coupon-#{@five_off.id}" do
        expect(page).to have_content(@five_off.name)
        expect(page).to have_content(@five_off.code)
        expect(page).to have_content(number_to_currency(@five_off.amount_off))
        expect(page).to have_content("Active: #{@five_off.active}")
      end

      within "#coupon-#{@two_off.id}" do
        expect(page).to have_content(@two_off.name)
        expect(page).to have_content(@two_off.code)
        expect(page).to have_content(number_to_currency(@two_off.amount_off))
        expect(page).to have_content("Active: #{@two_off.active}")
      end

    end

    it 'has a link to create more coupons' do
      click_link "Add a Coupon"
      expect(current_path).to eq(new_dashboard_coupon_path)
    end

    it 'has links to edit coupons' do

      within "#coupon-#{@five_off.id}" do
        expect(page).to have_link "Edit #{@five_off.name}"
      end

      within "#coupon-#{@two_off.id}" do
        click_link "Edit #{@two_off.name}"
      end

      expect(current_path).to eq(edit_dashboard_coupon_path(@two_off))
    end

  end
end
