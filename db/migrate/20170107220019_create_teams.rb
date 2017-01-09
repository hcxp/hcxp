class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :website
      t.string :slug
      t.text :description

      t.timestamps
    end
    add_index :teams, :slug, unique: true
  end
end
