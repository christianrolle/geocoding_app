class ChangeLongitudeAndLatitudePrecision < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :longitude, :decimal, precision: 10, scale: 7
    change_column :users, :latitude, :decimal, precision: 10, scale: 7
  end
end
