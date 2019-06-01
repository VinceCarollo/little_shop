require 'rails_helper'

RSpec.describe "As a registered user" do

  context 'when creating or editing my addresses' do

    before :each do
      @user_1 = User.create!(email: "test1@test.com", password: "pass", role: 0, active: true, name: "Testy McTesterson1")
      @user_1_home = @user_1.locations.create!(name: 'home', address: '123 Test St', city: "Testville", state: "home", zip: "home" )
      @user_1_work = @user_1.locations.create!(name: 'work', address: '123 work St', city: "worksvill", state: "work", zip: "work" )
      @user_1_moms = @user_1.locations.create!(name: 'moms', address: '123 moms St', city: "momsville", state: "moms", zip: "moms" )

      visit login_path

      fill_in "Email", with: 'test1@test.com'
      fill_in "Password", with: 'pass'

      click_button 'Login'
    end

    it 'will not let me create an address without a name' do
      visit profile_path

      click_link "Add Address"

      fill_in "Address", with: "123 School Rd."
      fill_in "City", with: "Schoolville"
      fill_in "State", with: "MO"
      fill_in "Zip", with: "12345"

      click_button 'Create Address'

      expect(current_path).to eq(user_locations_path(@user_1))
      expect(page).to have_content("Name can't be blank")
    end

    it 'shows all errors when creating an address' do
      visit profile_path

      click_link "Add Address"

      click_button 'Create Address'

      expect(current_path).to eq(user_locations_path(@user_1))
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Address can't be blank")
      expect(page).to have_content("City can't be blank")
      expect(page).to have_content("State can't be blank")
      expect(page).to have_content("Zip can't be blank")
    end

    it 'will not let me create an address with a duplicate name' do
      visit profile_path

      click_link "Add Address"

      fill_in "Name", with: "Home"
      fill_in "Address", with: "123 School Rd."
      fill_in "City", with: "Schoolville"
      fill_in "State", with: "MO"
      fill_in "Zip", with: "12345"

      click_button 'Create Address'

      expect(current_path).to eq(user_locations_path(@user_1))
      expect(page).to have_content("Name has already been taken")

    end
  end

end
