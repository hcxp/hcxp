class AddDescriptionToBands < ActiveRecord::Migration[5.1]
  def change
    add_column :bands, :description, :text
  end
end
