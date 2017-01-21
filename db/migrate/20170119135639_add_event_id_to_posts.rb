class AddEventIdToPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :event, foreign_key: true
  end
end
