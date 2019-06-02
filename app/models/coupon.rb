class Coupon < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates_presence_of :code
  validates :active, inclusion: { in: [ true, false ] }
  validates :amount_off, numericality: { only_integer: true }
end
