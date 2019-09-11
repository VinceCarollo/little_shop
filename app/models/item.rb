class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items


  validates_presence_of :name, :price, :description, :image, :inventory
  validates :price, :numericality => { :greater_than => 0 }
  validates :inventory, :numericality => { :greater_than => 0 }
  validates_inclusion_of :active, in: [true, false]

  def self.all_active
    where(active: true).includes(:user)
  end

  def self.most_5_bought
    self.joins(:order_items)
        .select('sum(quantity) AS order_quantity, items.*')
        .where('order_items.fulfilled=true')
        .group(:id)
        .order('order_quantity desc')
        .limit(5)
  end

  def self.least_5_bought
    self.joins(:order_items)
        .select('sum(quantity) AS order_quantity, items.*')
        .where('order_items.fulfilled=true')
        .group(:id)
        .order('order_quantity')
        .limit(5)
  end

  def average_days_to_fulfill
    order_items.where(fulfilled: true).average("order_items.updated_at - order_items.created_at")
  end
end
