class AddCountryCdeToVenues < ActiveRecord::Migration[5.0]
  def change
    add_column :venues, :country_code, :string
  end
end
