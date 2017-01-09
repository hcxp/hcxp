class AddTeamToEvents < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :team, foreign_key: true
  end
end
