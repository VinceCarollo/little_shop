require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'relationships' do
    it { should belong_to :item}
    it { should belong_to :order}
  end

  describe 'validations' do
    it { should validate_presence_of :quantity}
    it { should validate_presence_of :price}
  end

  describe 'instance methods' do
    before :each do
      @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 1, active: true, name: "Testy McTesterson")

      @merchant_1 = create(:user)

      @item_1 = create(:item, user: @merchant_1)

      @order_1 = create(:order, user: @user)

      @order_item_1 = create(:order_item, order: @order_1, item: @item_1, quantity: 2)
    end

    it '#sub_total' do
      expect(@order_item_1.sub_total).to eq(19.98)
    end
  end
end
