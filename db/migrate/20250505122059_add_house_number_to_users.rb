class AddHouseNumberToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :house_number, :string
  end
end
