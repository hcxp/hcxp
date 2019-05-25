class CreateBandEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :band_events do |t|
      t.references :band, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
