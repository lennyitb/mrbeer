class AddMaxOutstandingTab < ActiveRecord::Migration[7.0]
  def change
		change_table :users do |t|
      t.decimal :max_outstanding_tab, precision: 6, scale: 2, default: 0
    end
  end
end
