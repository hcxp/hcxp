class AddPlaceNameIdAndCordsToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :place_name, :string
    add_column :events, :nominatim_place_id, :string
    add_index :events, :nominatim_place_id
    add_column :events, :latitude, :float
    add_column :events, :longitude, :float
  end
end
