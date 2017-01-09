class AddAvatarToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :avatar, :string
  end
end
