class AddBandsCountToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :bands_count, :integer, default: 0
  end
end
