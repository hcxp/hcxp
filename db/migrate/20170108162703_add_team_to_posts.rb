class AddTeamToPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :team, foreign_key: true
  end
end
