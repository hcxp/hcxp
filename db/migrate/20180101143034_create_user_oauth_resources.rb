class CreateUserOauthResources < ActiveRecord::Migration[5.1]
  def change
    create_table :user_oauth_resources do |t|
      t.references :user, foreign_key: true
      t.string :uid
      t.string :provider

      t.timestamps
    end
    add_index :user_oauth_resources, :uid
  end
end
