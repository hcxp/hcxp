class AddOwnershipTypeToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :ownership_type, :string
  end
end
