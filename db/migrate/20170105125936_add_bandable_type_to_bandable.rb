class AddBandableTypeToBandable < ActiveRecord::Migration[5.0]
  def change
    add_column :bandable, :bandable_type, :string
  end
end
