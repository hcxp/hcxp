class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :url
      t.string :thumbnail
      t.references :user, foreign_key: true
      t.datetime :crawled_at

      t.timestamps
    end
  end
end
