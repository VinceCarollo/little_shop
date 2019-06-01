require 'rails_helper'

RSpec.describe "As a registered User" do

  describe "on my profile page" do

    before :each do
      @user_1 = User.create!(email: "test1@test.com", password: "pass", role: 0, active: true, name: "Testy McTesterson1")
      @user_1_home = @user_1.locations.create!(name: 'home', address: '123 Test St', city: "Testville", state: "home", zip: "home" )
      @user_1_work = @user_1.locations.create!(name: 'work', address: '123 work St', city: "worksvill", state: "work", zip: "work" )
      @user_1_moms = @user_1.locations.create!(name: 'moms', address: '123 moms St', city: "momsville", state: "moms", zip: "moms" )
      @order_1 = Order.create(user: @user_1, status: 1, location: @user_1_work)
      @order_2 = Order.create(user: @user_1, status: 2, location: @user_1_moms)

      visit login_path

      fill_in "Email", with: 'test1@test.com'
      fill_in "Password", with: 'pass'

      click_button 'Login'
    end

    it "allows deletion of addresses" do
      visit profile_path

      within "#location-#{@user_1_work.id}" do
        click_link "Delete #{@user_1_work.name.capitalize}"
      end

      expect(current_path).to eq(profile_path)

      expect(page).to_not have_content(@user_1_work.name)
      expect(page).to_not have_content(@user_1_work.address)
      expect(page).to_not have_content(@user_1_work.city)
      expect(page).to_not have_content(@user_1_work.state)
      expect(page).to_not have_content(@user_1_work.zip)
    end

    it "Doesn't allow deletion of addresses if part of order that is packaged or shipped" do
      visit profile_path

      within "#location-#{@user_1_moms.id}" do
        click_link "Delete #{@user_1_moms.name.capitalize}"
      end

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Your #{@user_1_moms.name} address is being used for a current order and cannot be deleted")

      within "#location-#{@user_1_moms.id}" do
        expect(page).to have_content(@user_1_moms.name)
        expect(page).to have_content(@user_1_moms.address)
        expect(page).to have_content(@user_1_moms.city)
        expect(page).to have_content(@user_1_moms.state)
        expect(page).to have_content(@user_1_moms.zip)
      end
    end

    it 'allows editing of locations' do
      visit profile_path

      within "#location-#{@user_1_work.id}" do
        click_link "Edit #{@user_1_work.name.capitalize}"
      end

      fill_in "Name", with: "Dads"
      fill_in "City", with: "Dadsville"

      click_button "Update Location"

      within "#location-#{@user_1_work.id}" do
        expect(page).to have_content('dads')
        expect(page).to have_content("Dadsville")
      end

    end

    it 'does not allow editing of locations if used in completed order' do
      visit profile_path

      within "#location-#{@user_1_moms.id}" do
        click_link "Edit #{@user_1_moms.name.capitalize}"
      end

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Your #{@user_1_moms.name} address is being used for a current order and cannot be edited")

      within "#location-#{@user_1_moms.id}" do
        expect(page).to have_content(@user_1_moms.name)
        expect(page).to have_content(@user_1_moms.address)
        expect(page).to have_content(@user_1_moms.city)
        expect(page).to have_content(@user_1_moms.state)
        expect(page).to have_content(@user_1_moms.zip)
      end

    end

    it 'allows creation of locations' do
      visit profile_path

      click_link "Add Address"

      fill_in "Name", with: "School"
      fill_in "Address", with: "123 School Rd."
      fill_in "City", with: "Schoolville"
      fill_in "State", with: "MO"
      fill_in "Zip", with: "12345"

      click_button 'Create Address'

      location = Location.last

      expect(location.user).to eq(@user_1)
      expect(location.name).to eq("School")

      expect(current_path).to eq(profile_path)

      within "#location-#{location.id}" do
        expect(page).to have_content(location.name)
        expect(page).to have_content(location.address)
        expect(page).to have_content(location.city)
        expect(page).to have_content(location.state)
        expect(page).to have_content(location.zip)
      end

    end
  end

end
