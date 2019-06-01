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
      save_and_open_page
    end

    it 'will not let me create an address with a duplicate name' do

    end

    it 'will not let me edit an address without a name'
    it 'shows me all errors when creating invalid address'
    it 'shows me all errors when editing invalid address'
  end

end
