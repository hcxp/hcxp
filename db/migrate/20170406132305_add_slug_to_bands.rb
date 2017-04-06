class AddSlugToBands < ActiveRecord::Migration[5.0]
  def change
    add_column :bands, :slug, :string
    add_index :bands, :slug, unique: true
  end
end
