require 'rails_helper'

RSpec.describe Coupon, type: :model do

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :code }
    it { should validate_presence_of :amount_off }
  end

  describe 'relationships' do
    it { should belong_to :user }
  end

end
