class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :price
      t.datetime :beginning_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
