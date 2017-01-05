class RenameEventIdToBandableIdOnBandable < ActiveRecord::Migration[5.0]
  def change
    rename_column :bandable, :event_id, :bandable_id
  end
end
