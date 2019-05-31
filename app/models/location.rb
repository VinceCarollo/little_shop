class Location < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :address, :city, :state, :zip

  validates_uniqueness_of :name, :scope => [:user_id]

  def validate!
    errors.add(:address, :blank, message: "can't be blank") if address.blank?
    errors.add(:city, :blank, message: "can't be blank") if city.blank?
    errors.add(:state, :blank, message: "can't be blank") if state.blank?
    errors.add(:zip, :blank, message: "can't be blank") if zip.blank?
  end
end
