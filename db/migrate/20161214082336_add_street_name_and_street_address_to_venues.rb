class AddStreetNameAndStreetAddressToVenues < ActiveRecord::Migration[5.0]
  def change
    add_column :venues, :street_name, :string
    add_column :venues, :street_number, :string
  end
end
