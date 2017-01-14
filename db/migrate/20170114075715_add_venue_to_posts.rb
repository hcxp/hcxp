class AddVenueToPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :venue, foreign_key: true
  end
end
