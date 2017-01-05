class RenameBandbaleToBandables < ActiveRecord::Migration[5.0]
  def change
    rename_table :bandable, :bandables
  end
end
