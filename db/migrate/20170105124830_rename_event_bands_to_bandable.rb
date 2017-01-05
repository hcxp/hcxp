class RenameEventBandsToBandable < ActiveRecord::Migration[5.0]
  def change
    rename_table :event_bands, :bandable
  end
end
