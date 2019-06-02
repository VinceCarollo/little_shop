class Coupon < ApplicationRecord
  belongs_to :user
  has_many :orders
  validates :name, presence: true, uniqueness: true
  validates_presence_of :code, uniqueness: true
  validates :active, inclusion: { in: [ true, false ] }
  validates :amount_off, numericality: { only_integer: true }
end
