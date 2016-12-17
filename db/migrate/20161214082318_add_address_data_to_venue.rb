class AddAddressDataToVenue < ActiveRecord::Migration[5.0]
  def change
    add_column :venues, :lat, :float
    add_column :venues, :lng, :float
    add_column :venues, :city, :string
    add_column :venues, :country, :string
  end
end
