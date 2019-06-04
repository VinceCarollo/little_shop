require 'rails_helper'

RSpec.describe 'As any kind of user on the system' do
  describe 'When I visit an items show page from the items catalog' do
    before :each do
      merchant_1 = create(:user)
      merchant_2 = create(:user)
      @item_1 = create(:item, user: merchant_1)
      @item_2 = create(:item, user: merchant_1)
      @item_3 = create(:item, user: merchant_1)
      @item_4 = create(:item, user: merchant_2)
      @item_5 = create(:item, user: merchant_2, active: false)
      @item_6 = create(:item, user: merchant_2, active: false)
      buyer_1 = create(:user)
      buyer_2 = create(:user)
      buyer_3 = create(:user)
      buyer_4 = create(:user)
      order_1 = create(:order, user: buyer_1)
      order_2 = create(:order, user: buyer_1)
      order_3 = create(:order, user: buyer_2)
      order_4 = create(:order, user: buyer_2)
      order_5 = create(:order, user: buyer_3)
      order_6 = create(:order, user: buyer_3)
      order_7 = create(:order, user: buyer_3)
      order_8 = create(:order, user: buyer_2)
      order_9 = create(:order, user: buyer_1)
      order_10 = create(:order, user: buyer_3)
      order_11 = create(:order, user: buyer_4)
      OrderItem.create!(item: @item_1, order: order_1, quantity: 12, price: 1.99, fulfilled: true, created_at: 4.days.ago, updated_at: 1.days.ago)
      OrderItem.create!(item: @item_2, order: order_2, quantity: 3, price: 6.99, fulfilled: true, created_at: 3.days.ago, updated_at: 1.days.ago)
      OrderItem.create!(item: @item_3, order: order_3, quantity: 6, price: 11.99, fulfilled: true, created_at: 3.days.ago, updated_at: 1.days.ago)
      OrderItem.create!(item: @item_4, order: order_4, quantity: 7, price: 12.99, fulfilled: true, created_at: 7.days.ago, updated_at: 1.days.ago)
      OrderItem.create!(item: @item_5, order: order_5, quantity: 14, price: 13.99, fulfilled: true, created_at: 10.days.ago, updated_at: 1.days.ago)
      OrderItem.create!(item: @item_6, order: order_6, quantity: 5, price: 2.99, fulfilled: true, created_at: 1.days.ago, updated_at: 1.days.ago)
      OrderItem.create!(item: @item_1, order: order_7, quantity: 21, price: 9.99, fulfilled: true, created_at: 2.days.ago, updated_at: 1.days.ago)
      OrderItem.create!(item: @item_2, order: order_8, quantity: 31, price: 7.99, fulfilled: true, created_at: 4.days.ago, updated_at: 1.days.ago)
      OrderItem.create!(item: @item_3, order: order_9, quantity: 2, price: 12.99, fulfilled: false, created_at: 5.days.ago, updated_at: 1.days.ago)
      OrderItem.create!(item: @item_4, order: order_10, quantity: 3, price: 11.99, fulfilled: false, created_at: 8.days.ago, updated_at: 1.days.ago)
      OrderItem.create!(item: @item_5, order: order_11, quantity: 1, price: 21.99, fulfilled: false, created_at: 9.days.ago, updated_at: 1.days.ago)
    end

    it 'any my url path is correct' do
      visit items_path

      within "#item-#{@item_1.id}" do
        click_on(@item_1.name)
      end

      expect(current_path).to eq(item_path(@item_1.id))
    end

    it 'shows the item page with text' do
      visit item_path(@item_1.id)

      within ".item-content" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.description)
        expect(page).to have_css("img[src*='#{@item_1.image}']")
        expect(page).to have_content("Merchant Name: #{@item_1.user.name}")
        expect(page).to have_content("Available Quantity: #{@item_1.inventory}")
        expect(page).to have_content("Price: $#{@item_1.price}")
        expect(page).to have_content("Average Time to Ship: #{@item_1.average_days_to_fulfill.round} Days")
      end
    end

    describe 'as a visitor or regular user, I can see a link to add item to cart' do
      it 'as a visitor' do
        visit item_path(@item_1.id)

        expect(page).to have_link('Add to Cart')
      end

      it 'as a regular user' do
        user = User.create!(email: "test@test.com", password_digest: "t3s7", role: :default, active: true, name: "Testy McTesterson")
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit item_path(@item_1.id)

        expect(page).to have_link('Add to Cart')
      end

      it 'as a merchant user' do
        user = User.create!(email: "test@test.com", password_digest: "t3s7", role: :merchant, active: true, name: "Testy McTesterson")
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit item_path(@item_1.id)

        expect(page).to have_no_link('Add to Cart')
      end

      it 'as an admin user' do
        user = User.create!(email: "test@test.com", password_digest: "t3s7", role: :admin, active: true, name: "Testy McTesterson")
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit item_path(@item_1.id)

        expect(page).to have_no_link('Add to Cart')
      end

      # The bulk of this functionality is tested in carts show spec
      it 'successfully adds items to cart' do
        visit item_path(@item_1.id)

        click_link "Add to Cart"

        expect(current_path).to eq(items_path)
        expect(page).to have_content("#{@item_1.name} has been added to your cart")
        expect(page).to have_content("(1)")
      end
    end
  end
end
