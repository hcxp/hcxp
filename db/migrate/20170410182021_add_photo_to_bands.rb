class AddPhotoToBands < ActiveRecord::Migration[5.0]
  def change
    add_column :bands, :photo, :string
  end
end
