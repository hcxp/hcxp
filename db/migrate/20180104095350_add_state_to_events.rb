class AddStateToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :state, :string
  end
end
