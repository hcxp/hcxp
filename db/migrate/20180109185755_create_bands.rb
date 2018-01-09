class CreateBands < ActiveRecord::Migration[5.1]
  def change
    create_table :bands do |t|
      t.string :uid
      t.string :name
      t.string :location
      t.string :photo_uid
      t.datetime :scrapped_at

      t.timestamps
    end
    add_index :bands, :uid
  end
end
