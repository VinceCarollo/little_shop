require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  context 'As a regular user' do
    describe 'When I visit my own profile page' do
      before :each do
        @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 0, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")
        @location_1 = @user.locations.create!(name: 'home', address: '123 Test St', city: "Testville", state: "Test", zip: "01234" )
        @location_2 = @user.locations.create!(name: 'work', address: '123 work St', city: "Testville", state: "Test", zip: "01234" )
        @location_3 = @user.locations.create!(name: 'moms', address: '123 moms St', city: "Testville", state: "Test", zip: "01234" )

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end

      it 'Then I can see all my information, except my password' do
        visit profile_path

        expect(page).to have_content(@user.email)
        expect(page).to have_content(@user.role)
        expect(page).to have_content(@user.active)
        expect(page).to have_content(@user.name)
        expect(page).to have_content(@user.address)
        expect(page).to have_content(@user.city)
        expect(page).to have_content(@user.state)
        expect(page).to have_content(@user.zip)

        expect(page).to_not have_content(@user.password_digest)
      end

      it 'I see a link to edit my information' do
        visit profile_path

        expect(page).to have_link("Edit Profile")

        click_on "Edit Profile"

        expect(current_path).to eq("/profile/edit")
      end

      describe 'And I have orders placed in the system' do
        it 'I can click on My Orders and navigate to profile/orders' do
          order_1 = @user.orders.create!(status: 0)

          visit profile_path

          expect(page).to have_link("My Orders")

          click_on "My Orders"

          expect(current_path).to eq(profile_orders_path)
        end
      end
      describe 'And I do not have orders placed in the system' do
        it 'I do not see My Orders link' do
          visit profile_path

          expect(page).to have_no_link("My Orders")
        end
      end

      it 'shows all my addresses' do
        visit profile_path

        within '#locations' do

          within "#location-#{@location_1.id}" do
            expect(page).to have_content(@location_1.name)
            expect(page).to have_content(@location_1.address)
            expect(page).to have_content(@location_1.city)
            expect(page).to have_content(@location_1.state)
            expect(page).to have_content(@location_1.zip)
          end

          within "#location-#{@location_2.id}" do
            expect(page).to have_content(@location_2.name)
            expect(page).to have_content(@location_2.address)
            expect(page).to have_content(@location_2.city)
            expect(page).to have_content(@location_2.state)
            expect(page).to have_content(@location_2.zip)
          end

          within "#location-#{@location_3.id}" do
            expect(page).to have_content(@location_3.name)
            expect(page).to have_content(@location_3.address)
            expect(page).to have_content(@location_3.city)
            expect(page).to have_content(@location_3.state)
            expect(page).to have_content(@location_3.zip)
          end

        end
      end
    end
  end
end
