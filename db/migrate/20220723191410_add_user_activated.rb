class AddUserActivated < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.boolean :enabled, default: true
      t.boolean :verified, default: false
    end
  end
end
