class AddOccuredAtToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :occured_at, :datetime
  end
end
