require 'rails_helper'

RSpec.describe 'As a visitor that is registering' do

  it 'saves my given sign up location as my home location' do

    visit register_path

    fill_in "Name", with: 'vince'
    fill_in "Address", with: '123 test rd'
    fill_in "City", with: 'KC'
    fill_in "State", with: 'MO'
    fill_in "Zip", with: '64086'
    fill_in "Email", with: 'vince@test.com'
    fill_in "Password", with: '1234'
    fill_in "Confirm password", with: '1234'
    click_button 'Create User'

    user_made = User.last
    user_location = Location.last
    expect(user_made.locations.length).to eq(1)
    expect(user_made.locations).to include(user_location)

  end

end
