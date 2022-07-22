class AddOrdersTable < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user
      t.decimal :charge_amount, precision: 6, scale: 2, default: "0.0", null: false
      t.string :message
      t.timestamps
    end
  end
end
