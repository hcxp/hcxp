class AddEventsCountToBands < ActiveRecord::Migration[5.0]
  def change
    add_column :bands, :events_count, :integer, default: 0
  end
end
