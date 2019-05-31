class AddShipLocationToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :location, foreign_key: true
  end
end
