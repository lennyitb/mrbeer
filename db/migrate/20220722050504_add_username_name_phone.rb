class AddUsernameNamePhone < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.string :username
      t.string :nickname
      t.string :phone, unique: true
    end
  end
end
