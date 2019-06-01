class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code
      t.integer :amount_off
      t.boolean :active, default: true
      t.references :user, foreign_key: true
    end
  end
end
