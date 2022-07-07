class AddAdminAndTab < ActiveRecord::Migration[7.0]
	def change
		change_table :users do |t|
			t.boolean :admin, :default => false
			t.decimal :min_price, precision: 6, scale: 2, default: 0
			t.decimal :max_price, precision: 6, scale: 2, default: 9999.99
			t.integer :price_percent, null: false, default: 100
		end
	end
end
