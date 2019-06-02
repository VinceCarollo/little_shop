require 'rails_helper'

RSpec.describe Coupon, type: :model do

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :code }
    it { should validate_numericality_of(:amount_off).only_integer }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :orders }
  end

end
