class AddShipLocationToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :location, foreign_key: {on_delete: :cascade}
  end
end
