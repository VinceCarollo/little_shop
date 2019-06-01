class Coupon < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates_presence_of :code, :amount_off
  validates :active, inclusion: { in: [ true, false ] }
end
