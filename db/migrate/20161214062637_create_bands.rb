class CreateBands < ActiveRecord::Migration[5.0]
  def change
    create_table :bands do |t|
      t.string :name
      t.string :location
      t.float :lat
      t.float :lng
      t.string :city
      t.string :country_code
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
