class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :facebook_event_id, index: true
      t.string :name
      t.string :city
      t.string :country_code
      t.datetime :start_at
      t.string :poster_uid

      t.timestamps
    end
  end
end
