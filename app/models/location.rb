class Location < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :address, :city, :state, :zip
end
