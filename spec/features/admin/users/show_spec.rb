require 'rails_helper'

RSpec.describe 'As an admin user' do
  describe 'when i click a new Users link' do
    before :each do
      @admin_1 = User.create!(email: "ron_admin@gmail.com", password: "12345", role: 2, active: true, name: "Ron")

      @merchant_1 = User.create!(email: "jon_mer@gmail.com", password: "12345", role: 1, active: true, name: "Jon a")
      @merchant_2 = User.create!(email: "ron_mer@gmail.com", password: "12345", role: 1, active: true, name: "Ron b")
      @user_1 = User.create!(email: "user1@gmail.com", password: "12345", role: 0, active: true, name: "Jon 1")
      @user_1_address = @user_1.locations.create!(name: 'home', address: "1234 Test Rd", city: "Kansas City", state: "MO", zip: '64086')
      @user_2 = User.create!(email: "user2@gmail.com", password: "12345", role: 0, active: true, name: "Ron 2")
      @user_3 = User.create!(email: "user3@gmail.com", password: "12345", role: 0, active: true, name: "Jon 3")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_1)
    end

    it 'view show page on a user' do
      visit admin_user_path(@user_1.id)

      expect(current_path).to eq(admin_user_path(@user_1.id))

      expect(page).to have_content(@user_1.email)
      expect(page).to have_content(@user_1.role)
      expect(page).to have_content(@user_1.active)
      expect(page).to have_content(@user_1.name)
      expect(page).to have_content(@user_1_address.address)
      expect(page).to have_content(@user_1_address.city)
      expect(page).to have_content(@user_1_address.state)
      expect(page).to have_content(@user_1_address.zip)

      expect(page).to_not have_content(@user_1.password_digest)
      expect(page).to_not have_link("Edit Profile")
    end

    it 'has an upgrade link for a user' do
      visit admin_user_path(@user_1.id)

      expect(current_path).to eq(admin_user_path(@user_1.id))
      expect(page).to have_link("Upgrade to Merchant")

      click_on("Upgrade to Merchant")

      expect(current_path).to eq("/admin/merchants/#{@user_1.id}")
      expect(@user_1.reload.role).to eq("merchant")
      within("#flash-message") do
        expect(page).to have_content("User #{@user_1.name} has been promoted to Merchant")
      end
    end
    it 'redirects from merchants show to users show' do
      visit "/admin/merchants/#{@user_1.id}"
      expect(current_path).to eq(admin_user_path(@user_1.id))
    end
  end
end
