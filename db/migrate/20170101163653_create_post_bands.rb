class CreatePostBands < ActiveRecord::Migration[5.0]
  def change
    create_table :post_bands do |t|
      t.references :post, foreign_key: true
      t.references :band, foreign_key: true

      t.timestamps
    end
  end
end
