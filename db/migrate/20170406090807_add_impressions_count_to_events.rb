class AddImpressionsCountToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :impressions_count, :integer, default: 0
  end
end
