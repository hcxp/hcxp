class CreateEventBands < ActiveRecord::Migration[5.0]
  def change
    create_table :event_bands do |t|
      t.references :event, foreign_key: true
      t.references :band, foreign_key: true

      t.timestamps
    end
  end
end
