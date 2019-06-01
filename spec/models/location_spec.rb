require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe 'relationships' do
    it { should belong_to :user }
  end

  describe 'instance methods' do

      before :each do
        user = create(:user)
        @subject = create(:location, user: user)
      end

      it { expect(@subject).to validate_presence_of(:name).with_message("can't be blank") }
      it { expect(@subject).to validate_presence_of(:address).with_message("can't be blank") }
      it { expect(@subject).to validate_presence_of(:city).with_message("can't be blank") }
      it { expect(@subject).to validate_presence_of(:state).with_message("can't be blank") }
      it { expect(@subject).to validate_presence_of(:zip).with_message("can't be blank") }

  end
end
